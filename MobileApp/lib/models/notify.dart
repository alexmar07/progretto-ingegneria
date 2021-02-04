import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:intl/intl.dart';

class Notify {
  int id;
  String username;
  String firstname;
  String lastname;

  Notify({this.id, this.username, this.firstname, this.lastname});

  factory Notify.fromRawJson(String str) => Notify.fromJson(json.decode(str));

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: int.parse(json['id']),
        username: json['username'],
        firstname: json['first_name'],
        lastname: json['last_name'],
      );
}
