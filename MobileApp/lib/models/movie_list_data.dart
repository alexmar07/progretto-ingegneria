import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MovieListData {
  MovieListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.n_reviews = 0,
    this.rating = 0.0,
    this.id = 0,
    this.genre = '',
    this.year = '',


  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double rating;
  int n_reviews;
  int id;
  String genre;
  String year;



  static List<MovieListData> movieList = <MovieListData>[];
  static MovieListData singleMovie;

  MovieListData.fromJson(Map<String, dynamic> json) {
    var items = json['items']['rows'];

    for ( var i in items) {
     movieList.add(MovieListData(
        id : i['id'],
        imagePath: i['cover_image'],
        titleTxt: i['name'],
        n_reviews: i['n_reviews'],
        rating: double.parse(i['valutation']),
      ));
    }
  }

  Future<MovieListData> fetchMovieListData() async {
    final response = await http.get('https://api.themoviedb.org/3/discover/movie?api_key=6094a309fc93881d4b116756680a382c&language=it-IT&sort_by=popularity.desc&include_adult=false&include_video=false&page=1');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieListData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<MovieListData> fetchSingleMovie( int id ) async {

    print('http://appprogetto.altervista.org/api/public/index.php/accommodations/' + id.toString());
    final response = await http.get('http://appprogetto.altervista.org/api/public/index.php/accommodations/' + id.toString() );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> json =  jsonDecode(response.body);
      var data = json['items'];

     singleMovie = MovieListData(
        id : data['id'],
        imagePath: data['cover_image'],
        titleTxt: data['name'],
        n_reviews: data['n_reviews'],
        rating: double.parse(data['valutation']),
        genre: data['genre'],
        year: data['year'],

      );
     print(singleMovie.imagePath);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}