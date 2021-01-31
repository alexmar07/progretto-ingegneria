import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:INGSW_MezMar/models/movie_list.dart';
import 'package:INGSW_MezMar/models/movie.dart';
import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_visitors.dart';

class MovieListVisitorsScreen extends StatefulWidget {
  @override
  _MovieListVisitorsScreenState createState() => _MovieListVisitorsScreenState();
}

class _MovieListVisitorsScreenState extends State<MovieListVisitorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MovieRepository().getMovies(1),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return new MovieListVisitorsView(movies: snapshot.data);
          }
        },
      ),
    );
  }
}

class MovieListVisitorsView extends StatefulWidget {
  final MovieList movies;

  const MovieListVisitorsView({
    this.movies,
    Key key,
  }) : super(key: key);

  @override
  _MovieListVisitorsViewState createState() => _MovieListVisitorsViewState();
}

class _MovieListVisitorsViewState extends State<MovieListVisitorsView> {
  ScrollController _scrollController = new ScrollController();

  List<Movie> movie;
  int currentPage = 1;

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              50) {
        MovieRepository().getMovies(currentPage + 1).then((val) {
          currentPage = val.page;
          setState(() {
            movie.addAll(val.movies);
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    movie = widget.movies.movies;
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
        itemCount: movie.length,
        controller: _scrollController,
        itemBuilder: (BuildContext ctx, int i) {
          return Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                    image: NetworkImage(movie[i].posterPath),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie[i].title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0),
                ),
                Expanded(
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(movie[i].voteAverage.toString(),
                          style: TextStyle(color: Colors.white)),
                    ),
                    RaisedButton.icon(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  SingleMovieVisitors(movie[i]),
                              fullscreenDialog: true),
                        );
                      },
                      label: Text('Dettagli'),
                      icon: Icon(Icons.keyboard_arrow_right),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
