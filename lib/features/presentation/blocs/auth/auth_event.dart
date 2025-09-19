part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class AuthRefreshTokenRequested extends AuthEvent {}

class AuthLoginSuccess extends AuthEvent {
  final String token;
  final String username;
  final String dbname;

  const AuthLoginSuccess({
    required this.token,
    required this.username,
    required this.dbname,
  });

  @override
  List<Object> get props => [token, username, dbname];
}