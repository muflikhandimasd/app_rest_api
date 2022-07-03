import 'dart:developer';
import 'package:app_rest_api/helpers/api_helper.dart';
import 'package:app_rest_api/helpers/shared_pref.dart';
import 'package:app_rest_api/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static final TextEditingController name = TextEditingController();
  static final TextEditingController email = TextEditingController();
  static final TextEditingController password = TextEditingController();

  void login() async {
    try {
      emit(AuthLoading());
      var header = {'Accept': 'application/json'};
      var url = Uri.parse(ApiHelper.baseUrl + ApiHelper.login);
      var request = await http.post(url, headers: header, body: {
        'email': email.text,
        'password': password.text,
      });

      var response = jsonDecode(request.body);
      // Save Token
      var pref = SharedPref();
      pref.saveToken(response['token']);
      // Save token
      var user = response['user'];
      emit(AuthSuccess(User.fromJson(user)));
      log(response);
    } catch (e) {
      log('Error $e');
      emit(AuthError('Error : $e'));
    }
  }

  void register() async {
    try {
      emit(AuthLoading());
      var header = {
        'Accept': 'application/json',
      };
      var url = Uri.parse(ApiHelper.baseUrl + ApiHelper.register);
      var request = await http.post(url, headers: header, body: {
        'name': name.text,
        'email': email.text,
        'password': password.text,
      });

      var response = jsonDecode(request.body);
      var token = response['token'];
      await SharedPref().saveToken(token);
      var user = response['data'];
      emit(AuthSuccess(User.fromJson(user)));
    } catch (e) {
      log('Error $e');
      emit(AuthError('Error : $e'));
    }
  }

  void logout() async {
    try {
      emit(AuthLoading());
      final token = await SharedPref().getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var url = Uri.parse(ApiHelper.baseUrl + ApiHelper.logout);
      var request = await http.post(
        url,
        headers: header,
      );
      var response = jsonDecode(request.body);
      var message = response['message'];
      log('Logout : $message');
      await SharedPref().removeToken();
    } catch (e) {
      log('Error $e');
      emit(AuthError('Error : $e'));
    }
  }
}
