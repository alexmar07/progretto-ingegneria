import 'package:intl/intl.dart';

class Movie {
  int id;
  String title;
  String image;
  String year;
  double rating;
  String overview;

  static const String IMAGE_PATH = 'https://image.tmdb.org/t/p/original/';

  Movie(
      {this.id = 0,
      this.title = '',
      this.image = '',
      this.year,
      this.rating = 0.00,
      this.overview});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
        id: json['id'],
        title: json['title'],
        image: IMAGE_PATH + json['backdrop_path'],
        year: !json['release_date'].isEmpty
            ? DateFormat("dd/MM/yyyy")
                .format(DateTime.parse(json['release_date']))
            : '',
        overview: json['overview'],
        rating: (json['vote_average']).toDouble());
  }
}
