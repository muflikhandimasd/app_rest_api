import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._();

  SharedPref._();

  factory SharedPref() => _instance;

  Future<void> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  Future getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString('token');
  }

  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }
}
