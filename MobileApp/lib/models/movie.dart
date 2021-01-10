import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:intl/intl.dart';

class Movie {
  int id;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  String overview;
  String releaseDate;

  Movie({
    this.id,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  factory Movie.fromJson(Map<String, dynamic> json) => new Movie(
        id: json["id"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        popularity: json["popularity"].toDouble(),
        posterPath: Config.imageBaseUrl + json["poster_path"],
        originalTitle: json["original_title"],
        genreIds: new List<int>.from(json["genre_ids"].map((x) => x)),
        backdropPath: Config.imageBaseUrl + json["backdrop_path"],
        overview: json["overview"],
        releaseDate: DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(json['release_date'])),
      );
}
