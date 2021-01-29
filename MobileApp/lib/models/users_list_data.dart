import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class UsersListData {
  UsersListData({
    this.name = '',
    this.surname = '',
    this.username = '',
    this.id = 0,
  });

  String name;
  String surname;
  String username;
  int id;

  static List<UsersListData> usersList = <UsersListData>[];
  static UsersListData singleUser;

  UsersListData.fromJson(Map<String, dynamic> json) {
    var items = json['items']['rows'];
    for (var i in items) {
      usersList.add(UsersListData(
        id: i['id'],
        name: i['name'],
        surname: i['surname'],
        username: i['username'],
      ));
    }
  }

  Future<UsersListData> fetchUsersListData() async {
    final response = await http.get(
        'http://appprogetto.altervista.org/api/public/index.php/accommodations');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return UsersListData.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<UsersListData> fetchSingleUser(int id) async {
    final response = await http.get(
        'http://appprogetto.altervista.org/api/public/index.php/accommodations/' +
            id.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      var data = json['items'];

      singleUser = UsersListData(
        id: data['id'],
        name: data['name'],
        surname: data['surname'],
        username: data['username'],
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
