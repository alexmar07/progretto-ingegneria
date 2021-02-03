import 'dart:convert';

import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:INGSW_MezMar/write_review.dart';
import 'models/movie.dart';
import 'models/reviews.dart';
import 'models/reviews_list.dart';

Color textColor = Colors.black54;
Color textSecondry = Colors.grey;

class SingleMovie extends StatefulWidget {
  SingleMovie(this.movie);
  Movie movie;
  @override
  _SingleMovieState createState() => _SingleMovieState(movie);
}

class _SingleMovieState extends State<SingleMovie> {
  _SingleMovieState(this.movie);
  var token;
  Movie movie;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: FlatButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WriteReview(movieId: movie.id)),
            );
          },
          textColor: Colors.white,
          child: Text(
            'SCRIVI UNA RECENSIONE',
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(imageUrl: movie.backdropPath),
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            child: Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          movie.title,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: textColor),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: Text(
                                    'Data di rilascio: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: textColor,
                                        fontFamily: 'Quicksand'),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Text(
                                  movie.releaseDate,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: textColor,
                                      fontFamily: 'Quicksand'),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: Text(
                                    'Valutazione',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: textColor,
                                        fontFamily: 'Quicksand'),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Text(movie.voteAverage.toString()),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () async {
                                        String message = await MovieRepository()
                                            .addMovieList(movie.id, 'prefer');

                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(message),
                                              );
                                            });
                                      }),
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.teal,
                                      ),
                                      onPressed: () async {
                                        String message = await MovieRepository()
                                            .addMovieList(movie.id, 'to_see');

                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(message),
                                              );
                                            });
                                      }),
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              indicatorColor: Theme.of(context).primaryColor,
                              labelColor: textColor,
                              unselectedLabelColor: textColor,
                              isScrollable: true,
                              tabs: [
                                Tab(
                                  text: 'Panoramica',
                                ),
                                Tab(
                                  text: 'Recensioni',
                                )
                              ],
                            ),
                            Container(
                                height: 300.0,
                                child: TabBarView(children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(movie.overview.isEmpty
                                        ? 'Panoramica non disponibile.'
                                        : movie.overview),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: FutureBuilder(
                                      future: MovieRepository()
                                          .getReviewsByMovie(movie.id, 1),
                                      builder: (BuildContext ctx,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return MovieReviewsView(
                                              reviews: snapshot.data,
                                              movie: movie);
                                        }
                                      },
                                    ),
                                  ),
                                ]))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieReviewsView extends StatefulWidget {
  final ReviewsList reviews;
  final Movie movie;

  const MovieReviewsView({
    this.reviews,
    this.movie,
    Key key,
  }) : super(key: key);

  @override
  _MovieReviewsViewState createState() => _MovieReviewsViewState();
}

class _MovieReviewsViewState extends State<MovieReviewsView> {
  ScrollController _scrollController = new ScrollController();

  List<Reviews> reviews;
  Movie movie;
  int currentPage = 1;

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              50) {
        MovieRepository()
            .getReviewsByMovie(movie.id, currentPage + 1)
            .then((val) {
          currentPage = val.page;
          setState(() {
            if (reviews.isNotEmpty) {
              reviews.addAll(val.reviews);
              return false;
            }
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    reviews = widget.reviews.reviews;
    movie = widget.movie;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: ListView.builder(
        itemCount: reviews.length,
        controller: _scrollController,
        itemBuilder: (BuildContext ctx, int i) {
          return itemCard(reviews[i]);
        },
      ),
    );
  }

  Widget itemCard(Reviews review) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
      child: Container(
        height: 140.0,
        width: double.infinity,
        //color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      review.username,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 15.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      review.title,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 17.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      review.description,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 17.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
