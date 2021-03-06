import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:INGSW_MezMar/models/movie_list_prefer_to_see.dart';
import 'package:flutter/material.dart';
import 'models/tabs.dart';
import 'package:provider/provider.dart';
import 'package:INGSW_MezMar/models/movie.dart';

class ToSee extends StatefulWidget {
  @override
  _ToSeeState createState() => _ToSeeState();
}

class _ToSeeState extends State<ToSee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Provider.of<Tabs>(context).changeIndex(0);
          },
        ),
        title: Text(
          'Lista di film preferiti',
          style: TextStyle(
              fontFamily: 'poppins-regular', fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
        future: MovieRepository().getMyMovieList('to_see'),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ToSeeListView(movies: snapshot.data);
          }
        },
      ),
    );
  }
}

class ToSeeListView extends StatefulWidget {
  final MovieListPreferToSee movies;

  ToSeeListView({this.movies, Key key}) : super(key: key);

  @override
  _ToSeeListViewState createState() => _ToSeeListViewState();
}

class _ToSeeListViewState extends State<ToSeeListView> {
  List<Movie> movies;
  String message;

  @override
  void initState() {
    movies = widget.movies.movies;
    message = widget.movies.message;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
      child: movies.isEmpty
          ? Center(child: Text('Non ci sono film'))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext ctx, int i) {
                return Dismissible(
                    key: Key(movies[i].title),
                    onDismissed: (direction) => {
                          setState(() {
                            MovieRepository()
                                .removeMovieList(movies[i].id, 'to_see');
                            movies.removeAt(i);
                          })
                        },
                    child: itemCard(movies[i]));
              },
            ),
    );
  }
}

Widget itemCard(Movie movie) {
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
          Container(
            width: 130.0,
            height: 160.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                image: DecorationImage(
                    image: NetworkImage(movie.backdropPath),
                    fit: BoxFit.cover)),
          ),
          SizedBox(width: 4.0),
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
                    movie.title,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 17.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: 175.0,
                    child: Text(
                      'Anno di uscita ' + movie.releaseDate,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              Container(
                height: 55.0,
                width: 140.0,
                child: Text(
                  movie.voteAverage.toString() + '/10',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.teal,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 20.0,
                width: 140.0,
                child: Text(
                  'Trascina per rimuovere',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.blueGrey,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
