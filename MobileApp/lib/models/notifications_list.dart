import 'dart:convert';

import 'package:INGSW_MezMar/models/notify.dart';
import 'package:INGSW_MezMar/models/reviews.dart';

class NotificationsList {
  List<Notify> notifications;
  bool success;
  String message;
  int page;

  NotificationsList(
      {this.notifications, this.success, this.message, this.page});

  factory NotificationsList.fromRawJson(String str) =>
      NotificationsList.fromJson(json.decode(str));

  factory NotificationsList.fromJson(Map<String, dynamic> json) {
    print(json);
    return NotificationsList(
        notifications: json["data"] == null
            ? new List<Notify>()
            : new List<Notify>.from(
                json["data"]['notifications'].map((x) => Notify.fromJson(x))),
        success: json['success'],
        page: json['page'],
        message: json['message']);
  }
}
