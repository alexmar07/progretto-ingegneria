import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:INGSW_MezMar/models/movie_list_prefer_to_see.dart';
import 'package:flutter/material.dart';
import 'models/tabs.dart';
import 'package:provider/provider.dart';
import 'package:INGSW_MezMar/models/movie.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
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
          future: MovieRepository().getMyMovieList('prefer'),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return new SavedListView(movies: snapshot.data);
            }
          },
        ));
  }
}

class SavedListView extends StatefulWidget {
  final MovieListPreferToSee movies;

  SavedListView({this.movies, Key key}) : super(key: key);

  @override
  _SavedListViewState createState() => _SavedListViewState();
}

class _SavedListViewState extends State<SavedListView> {
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
                                .removeMovieList(movies[i].id, 'prefer');
                            movies.removeAt(i);
                          })
                        },
                    child: itemCard(movies[i]));
              },
            ),
    );
  }

  Widget itemCard(Movie movie) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
      child: Container(
        height: 120.0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 25.0,
                      width: 80.0,
                      child: Text(
                        movie.voteAverage.toString(),
                        style: TextStyle(
                            fontSize: 19.0,
                            color: Colors.orangeAccent,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 55.0),
                    Container(
                      child: FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          MovieRepository().removeMovieList(movie.id, 'prefer');
                        },
                        textColor: Colors.white,
                        child: Icon(Icons.favorite_border),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
