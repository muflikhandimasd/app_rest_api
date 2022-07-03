part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AppUserChanged extends AppEvent {
  AppUserChanged(this.user);
  final User user;
}

class AppLoginCheck extends AppEvent {}

class AppLogoutRequested extends AppEvent {
  final BuildContext context;
  AppLogoutRequested(this.context);
}
