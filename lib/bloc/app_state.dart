part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, initial }

class AppState {
  final User? user;
  final AppStatus status;

  const AppState._({required this.status, this.user});

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.initial() : this._(status: AppStatus.initial);

  bool get isLogin => status == AppStatus.authenticated;
  bool get isLogout => status == AppStatus.unauthenticated;
  bool get isLoading => status == AppStatus.initial;
}
