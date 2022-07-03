import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._();

  SharedPref._();

  factory SharedPref() => _instance;

  saveRememberMe(bool isRemember) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("remember", isRemember);
  }

  Future getRememberMe() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("remember");
  }

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

  Future<void> removeEmailAndPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('login');
  }

  Future<void> removeRemember() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('remember');
  }

  saveEmailAndPassword(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('login', [email, password]);
  }

  Future getEmailAndPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('login');
  }
}
