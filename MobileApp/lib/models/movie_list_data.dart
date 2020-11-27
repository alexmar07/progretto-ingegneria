import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MovieListData {
  MovieListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.reviews = 80,
    this.rating = 0.0,
    this.id = 0,
    this.address = '',
    this.city = '',
    this.province = '',
    this.type = '',
    this.priceRange = '',

  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;
  int id;
  String address;
  String city;
  String province;
  String type;
  String priceRange;


  static List<MovieListData> movieList = <MovieListData>[];
  static MovieListData singleMovie;

  MovieListData.fromJson(Map<String, dynamic> json) {
    var items = json['items']['rows'];

    for ( var i in items) {
     movieList.add(MovieListData(
        id : i['id'],
        imagePath: i['cover_image'],
        titleTxt: i['name'],
        reviews: i['n_reviews'],
        rating: double.parse(i['valutation']),
      ));
    }
  }

  Future<MovieListData> fetchMovieListData() async {
    final response = await http.get('http://appprogetto.altervista.org/api/public/index.php/accommodations');
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
        reviews: data['n_reviews'],
        rating: double.parse(data['valutation']),
        address: data['address'],
        city: data['city'],
        province: data['province'],
        type: data['type'],
        priceRange: data['type_price'],
      );
     print(singleMovie.imagePath);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}