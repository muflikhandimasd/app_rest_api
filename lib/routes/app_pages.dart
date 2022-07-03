import 'package:app_rest_api/bloc/app_bloc.dart';
import 'package:app_rest_api/ui/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/pages/home/home_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final Map<String, WidgetBuilder> pages = {
    Routes.INITIAL: ((context) => BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Scaffold(
                body: Center(
                  child: Text('Loading...'),
                ),
              );
            }
            if (state.isLogin) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ))
  };
}
