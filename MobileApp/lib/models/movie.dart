class Movie {
  int id;
  String title;
  String image;
  String year;
  double rating;

  static const String IMAGE_PATH = 'https://image.tmdb.org/t/p/original/';

  Movie({
    this.id = 0,
    this.title = '',
    this.image = '',
    this.year = '',
    this.rating = 0.00,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
        id: json['id'],
        title: json['title'],
        image: IMAGE_PATH + json['backdrop_path'],
        year: json['release_year'],
        rating: (json['vote_average']).toDouble());
  }
}
