part of 'routing_tab_cubit.dart';

@immutable
abstract class RoutingTabState {}

enum RoutingAnimation { left, right, up, down }

class RoutingTabNavigator extends RoutingTabState {
  final String title;
  final Widget widget;
  final RoutingAnimation animate;

  RoutingTabNavigator(
      {required this.title,
      required this.widget,
      this.animate = RoutingAnimation.left});
}
