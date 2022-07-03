import 'package:app_rest_api/ui/pages/home/home_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'routing_tab_state.dart';

class RoutingTabCubit extends Cubit<RoutingTabState> {
  RoutingTabCubit()
      : super(RoutingTabNavigator(title: 'CRUD', widget: const HomePage()));

  void changeNavigator(
      {required String title,
      required Widget widget,
      RoutingAnimation animation = RoutingAnimation.down}) {
    emit(RoutingTabNavigator(title: title, widget: widget, animate: animation));
  }
}
