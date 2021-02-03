import 'dart:convert';

import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:INGSW_MezMar/write_review.dart';
import 'models/movie.dart';

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

  Widget buildicons(index) {
    List<Widget> widgets = List<Widget>();
    for (int i = 0; i < int.tryParse(index); i++) {
      widgets.add(Icon(
        Icons.star,
        color: Colors.orange[100],
        size: 15,
      ));
    }
    return Row(children: widgets);
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
                                        print(message);
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
                                    child: Text('QUI CI VANNO LE RECENSIONI'),
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
  /**
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<MovieListData>('movie', movie));
  }
   */
}
