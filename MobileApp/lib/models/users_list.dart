import 'dart:convert';

import 'package:INGSW_MezMar/models/users.dart';

class UsersList {
  List<Users> users;
  bool success;
  String message;
  int page;

  UsersList({this.users, this.success, this.message, this.page});

  factory UsersList.fromRawJson(String str) =>
      UsersList.fromJson(json.decode(str));

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
      users: json['data'] == null
          ? new List<Users>()
          : new List<Users>.from(json["data"].map((x) => Users.fromJson(x))),
      success: json['success'],
      page: json['page'],
      message: json['message']);
}
