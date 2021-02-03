import 'dart:convert';

class Reviews {
  int id;
  String title;
  String description;
  int valutation;
  String username;

  Reviews({
    this.id,
    this.title,
    this.description,
    this.valutation,
    this.username,
  });

  factory Reviews.fromRawJson(String str) => Reviews.fromJson(json.decode(str));

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
      id: int.parse(json["id"]),
      title: json["title"],
      description: json["description"],
      valutation: int.parse(json["valutation"]),
      username: json["username"]);
}
