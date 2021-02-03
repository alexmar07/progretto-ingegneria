import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:INGSW_MezMar/models/users_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsersRepository {
  Future<UsersList> getUsers(int currentPage, String query) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Config.apiUrl + '/users/list?page=' + currentPage.toString();
    print(query);
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
        headers: {"Authorization": prefs.getString('token')},
        body: json.encode({"user_id": userId}));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res);
      String message = res['message'];
      print(message);
      return message;
    }
  }
}
