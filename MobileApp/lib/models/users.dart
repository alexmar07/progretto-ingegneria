import 'dart:convert';

class Users {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;

  Users({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      id: int.parse(json["id"]),
      username: json["username"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"]);
}
