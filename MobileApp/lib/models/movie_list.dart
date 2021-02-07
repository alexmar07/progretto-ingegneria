import 'dart:convert';

import 'package:INGSW_MezMar/models/movie.dart';

class MovieList {
  List<Movie> movies;
  int page;
  int totalResults;
  int totalPages;

  MovieList({this.movies, this.page, this.totalResults, this.totalPages});

  factory MovieList.fromRawJson(String str) =>
      MovieList.fromJson(json.decode(str));

  factory MovieList.fromJson(Map<String, dynamic> json) => new MovieList(
        movies: json['results'] == null
            ? new List<Movie>()
            : new List<Movie>.from(
                json["results"].map((x) => Movie.fromJson(x))),
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );
}
