import 'dart:convert';

import 'package:INGSW_MezMar/models/reviews.dart';

class ReviewsList {
  List<Reviews> reviews;
  bool success;
  String message;
  int page;

  ReviewsList({this.reviews, this.success, this.message, this.page});

  factory ReviewsList.fromRawJson(String str) =>
      ReviewsList.fromJson(json.decode(str));

  factory ReviewsList.fromJson(Map<String, dynamic> json) => ReviewsList(
      reviews: json["data"] == null
          ? new List<Reviews>()
          : new List<Reviews>.from(
              json["data"].map((x) => Reviews.fromJson(x))),
      success: json['success'],
      page: json['page'],
      message: json['message']);
}
