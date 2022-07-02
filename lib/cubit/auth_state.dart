part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
