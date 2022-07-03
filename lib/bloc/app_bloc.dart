import 'dart:convert';
import 'dart:developer';

import 'package:app_rest_api/helpers/api_helper.dart';
import 'package:app_rest_api/helpers/shared_pref.dart';
import 'package:app_rest_api/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.initial()) {
    on<AppLoginCheck>(_onLoginCheck);
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
  }

  void _onAppLogoutRequested(
      AppLogoutRequested event, Emitter<AppState> emit) async {
    emit(const AppState.unauthenticated());
    await SharedPref().removeToken();
    await SharedPref().removeRemember();
    await SharedPref().removeEmailAndPassword();
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    emit(AppState.authenticated(event.user));
  }

  void _onLoginCheck(AppLoginCheck event, Emitter<AppState> emit) async {
    final value = await SharedPref().getRememberMe();
    if (value == true) {
      final data = await SharedPref().getEmailAndPassword();
      try {
        final email = data[0];
        final password = data[1];
        var url = Uri.parse(ApiHelper.baseUrl + ApiHelper.login);
        var request = await http
            .post(url, body: {'email': email, 'password': password}).timeout(
                const Duration(seconds: 60), onTimeout: () {
          throw Error();
        });
        var response = jsonDecode(request.body);
        if (response['api_status'] == 200) {
          SharedPref().saveToken(response['token']);
          final userData = response['user'];
          add(AppUserChanged(
            User(
              id: userData['id'],
              name: userData['name'],
              email: userData['email'],
            ),
          ));
        }
      } catch (e) {
        log('Error : $e');
        emit(const AppState.unauthenticated());
      }
    }
  }
}
