class Movie {
  int id;
  String title;
  String image;
  String year;
  double rating;

  Movie({
    this.id = 0,
    this.title = '',
    this.image = '',
    this.year = '',
    this.rating = 0.0,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return new Movie(
        id: json['id'],
        title: json['title'],
        image: json['backdrop_path'],
        year: json['release_year'],
        rating: json['vote_averange']);
  }
}
