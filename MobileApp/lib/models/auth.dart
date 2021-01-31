import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:INGSW_MezMar/models/users_singleton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool _state = false;
  String _token;
  String get token => _token;
  bool get state => _state;
  String _username;
  String _password;
  String _errorMessage;
  String get errorMessage => _errorMessage;

  void setUsername(username) => _username = username;
  void setPassword(password) => _password = password;

  void changeToken(t) async {
    _token = t;
    notifyListeners();
  }

  void login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
    _state = true;
    notifyListeners();
  }

  dynamic getJwt() async {
    var response = await http.post(Config.apiUrl + '/login',
        body: {'username': _username, 'password': _password});

    var json = jsonDecode(response.body);
    if (json['success'] == true) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(json['data']['jwt']);
      var user = UsersSingleton.instance;

      user.setUsername(decodedToken['username']);
      return json['data']['jwt'];
    } else {
      _errorMessage = json['message'];
      return false;
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _state = false;
    notifyListeners();
  }
}
