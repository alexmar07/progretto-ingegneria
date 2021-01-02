import 'dart:convert';
import 'dart:developer';
import 'package:INGSW_MezMar/models/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MovieListData {
  MovieListData({this.page, this.totalResult, this.totalPage, this.movies});

  final List<Movie> movies;

  int page = 1;
  int totalResult = 0;
  int totalPage = 0;

  static const API =
      'https://api.themoviedb.org/3/discover/movie?api_key=6094a309fc93881d4b116756680a382c&language=it-IT&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';

  factory MovieListData.fromJson(Map<String, dynamic> json) {
    var results = json['results'] as List;
    List<Movie> movies = results.map((i) => Movie.fromJson(i)).toList();
    return new MovieListData(
        page: json['page'],
        totalPage: json['total_page'],
        totalResult: json['total_results'],
        movies: movies);
  }

  Future<MovieListData> fetchMovieListData() async {
    final response = await http.get(API);

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
}
