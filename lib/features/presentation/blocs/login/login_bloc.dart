import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/core/constants/app_constants.dart';
import 'package:reservas_app/features/domain/usecases/login_use_case.dart';
import 'package:reservas_app/features/domain/usecases/reservas_advance_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase, required ReservasAdvanceUseCase reservasAdvanceUseCase}) : 
  _loginUseCase = loginUseCase,
  super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginReset>(_onReset);
  }

    void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final isValid = _isValidUsername(event.username);
    emit(
      state.copyWith(
        username: event.username,
        isUsernameValid: isValid,
        status: LoginStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final isValid = _isValidPassword(event.password);
    emit(
      state.copyWith(
        password: event.password,
        isPasswordValid: isValid,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    print('Login submitted with state: $state');
    if (!state.isFormValid) return;

    emit(state.copyWith(status: LoginStatus.loading));

    final result = await _loginUseCase(
      LoginParams(
        username: state.username,
        password: state.password,
        numeroUnico: AppConstants.numeroUnico, // Usando el valor del catálogo
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (success) => emit(
        state.copyWith(
          status: LoginStatus.success,
        ),
      ),
    );
  }

  void _onReset(
    LoginReset event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginState());
  }

  bool _isValidUsername(String username) {
    return username.trim().isNotEmpty && username.length >= AppConstants.minUsernameLength;
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= AppConstants.minPasswordLength;
  }

  
}
