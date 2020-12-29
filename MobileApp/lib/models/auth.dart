import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool _state = false;
  String _token;
  String get token => _token;
  bool get state => _state;
  String _email;
  String _password;
  String _errorMessage;
  String get errorMessage  => _errorMessage;

  static const API = 'http://appprogetto.altervista.org/index.php/login';

  void setEmail(email)  => _email =  email;
  void setPassword(password)  => _password =  password;

  void changeToken(t) async{
    _token = t;
    notifyListeners();
  }
  void login() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
    _state = true;
    print('Login');
    notifyListeners();
  }

  dynamic getJwt() async {
    var response = await http.post(API, body: {'email': _email, 'password': _password});
    var json = jsonDecode(response.body);
    if ( json['success'] == true) {
      print(json['data']['jwt']);
      return json['data']['jwt'];
    }
    else {
      _errorMessage = json['message'];
      return false;
    }
  }

  void logout() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _state = false;
    print('Logout');
    notifyListeners();
  }
}
