part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  final String username;
  final String dbname;

  const AuthAuthenticated({
    required this.token,
    required this.username,
    required this.dbname,
  });

  @override
  List<Object?> get props => [token, username, dbname];
}

class AuthUnauthenticated extends AuthState {}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}