import 'dart:convert';

import 'package:INGSW_MezMar/models/movie.dart';

class MovieListPreferToSee {
  List<Movie> movies;
  String message;

  MovieListPreferToSee({this.movies, this.message});

  factory MovieListPreferToSee.fromRawJson(String str) =>
      MovieListPreferToSee.fromJson(json.decode(str));

  factory MovieListPreferToSee.fromJson(Map<String, dynamic> json) =>
      new MovieListPreferToSee(
        message: json['message'],
        movies: json.containsKey('data')
            ? new List<Movie>.from(json["data"].map((x) => Movie.fromJson(x)))
            : new List(),
      );
}
