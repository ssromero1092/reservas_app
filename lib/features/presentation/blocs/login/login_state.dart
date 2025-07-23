part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String username;
  final String password;
  final String? errorMessage;
  final bool isUsernameValid;
  final bool isPasswordValid;

  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.errorMessage,
    this.isUsernameValid = false,
    this.isPasswordValid = false,
  });

  bool get isFormValid =>
      isUsernameValid && isPasswordValid;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    String? errorMessage,
    bool? isUsernameValid,
    bool? isPasswordValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        username,
        password,
        errorMessage,
        isUsernameValid,
        isPasswordValid,
      ];
}
