import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:INGSW_MezMar/models/notifications_list.dart';
import 'package:INGSW_MezMar/models/users_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsersRepository {
  Future<UsersList> getUsers(int currentPage, String query) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Config.apiUrl + '/users/list?page=' + currentPage.toString();

    if (query.isNotEmpty) {
      url += '&q=' + query;
    }

    final response = await http
        .get(url, headers: {"Authorization": prefs.getString('token')});
    print(url);
    if (response.statusCode == 200) {
      return UsersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }

  dynamic sendRequestLink(int userId) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Config.apiUrl + '/users/request';
    final response = await http.post(url,
        headers: {
          "Authorization": prefs.getString('token'),
          'Content-type': 'application/json'
        },
        body: json.encode({"user_id": userId}));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      String message = res['message'];
      return message;
    }
  }

  dynamic registerUsers(Map<String, dynamic> user) async {
    var url = Config.apiUrl + '/users/register';

    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(user));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Faild to load');
    }
  }

  Future<NotificationsList> getNotifications(int currentPage) async {
    final prefs = await SharedPreferences.getInstance();

    var url =
        Config.apiUrl + '/users/notifications?page=' + currentPage.toString();

    final response = await http
        .get(url, headers: {"Authorization": prefs.getString('token')});

    if (response.statusCode == 200) {
      return NotificationsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }

  dynamic acceptOrRefuseRequest(int notificationId, String action) async {
    final prefs = await SharedPreferences.getInstance();
    var url =
        Config.apiUrl + '/users/notifications/' + notificationId.toString();

    final response = await http.put(url,
        headers: {
          'Content-type': 'application/json',
          "Authorization": prefs.getString('token')
        },
        body: json.encode({"action": action}));
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);
    }
  }
}
