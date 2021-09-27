import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodlistdicoding/bloc/list_food_bloc.dart';
import 'package:foodlistdicoding/event/food_list_event.dart';
import 'package:foodlistdicoding/widget/search_widget.dart';
import '../state/food_list_state.dart';
import 'detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ListFoodBloc foodBloc;
  List<dynamic> data;

  // bool isLoading = false;
  String query = '';
  String hintText = 'Search...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                'FOOD & FOOD ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 2.0, 3.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSearch(),

                      SizedBox(height: 20),

                      Align(
                        child: Text(
                          '"TAKE A BITE" PLACES',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        alignment: Alignment.center,
                      ),

                      // buildList(list)
                      BlocProvider(
                          create: (context) =>
                              ListFoodBloc()..add(GetListFood()),
                          child: BlocBuilder<ListFoodBloc, ListFoodState>(
                              builder: (context, state) {
                            foodBloc = BlocProvider.of<ListFoodBloc>(context);
                            if (state is OnListFoodState) {
                              if (state.listFood.restaurants.length > 0) {
                                return Stack(
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            state.listFood.restaurants.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return DetailScreen(state
                                                    .listFood
                                                    .restaurants[index]
                                                    .id);
                                              }));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 22,
                                                    vertical: 10),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset: Offset(
                                                        0.0,
                                                        10.0,
                                                      ),
                                                      blurRadius: 10.0,
                                                      spreadRadius: -6.0,
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.multiply,
                                                    ),
                                                    image: NetworkImage(
                                                        "https://restaurant-api.dicoding.dev/images/small/" +
                                                            state
                                                                .listFood
                                                                .restaurants[
                                                                    index]
                                                                .pictureId),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        child: Text(
                                                          state
                                                              .listFood
                                                              .restaurants[
                                                                  index]
                                                              .name,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                    Align(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                    width: 7),
                                                                Text(
                                                                  '${state.listFood.restaurants[index].rating.toString()}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .pin_drop,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                    width: 7),
                                                                Text(
                                                                  '${state.listFood.restaurants[index].city}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset('images/loop.png'),
                                        width: 100,
                                        height: 100,
                                      ),
                                      Text(
                                        "no data",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }))
                    ],
                  )),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  void searchData(String query) {
    foodBloc..add(GetListFoodSearch(query: query));
  }

  Widget buildSearch() =>
      SearchWidget(text: query, onChanged: searchData, hintText: hintText);
}
