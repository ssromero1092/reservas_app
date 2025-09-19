import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/core/constants/app_constants.dart';
import 'package:reservas_app/core/storage/secure_storage.dart';
import 'package:reservas_app/core/storage/shared_preferences.dart';
import 'package:reservas_app/features/domain/usecases/login_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageRepository _secureStorage;
  final SharedPreferencesRepository _sharedPreferences;
  final LoginUseCase _loginUseCase;

  AuthBloc({
    required SecureStorageRepository secureStorage,
    required SharedPreferencesRepository sharedPreferences,
    required LoginUseCase loginUseCase,
  }) : _secureStorage = secureStorage,
       _sharedPreferences = sharedPreferences,
       _loginUseCase = loginUseCase,
       super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthLoginSuccess>(_onAuthLoginSuccess);
    on<AuthRefreshTokenRequested>(_onAuthRefreshTokenRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final token = await _secureStorage.getToken();
      final isLoggedIn = _sharedPreferences.getBool(AppConstants.cachedUsuarioKey);
      
      if (token != null && token.isNotEmpty && isLoggedIn) {
        // Verificar que también tengamos los datos necesarios
        final dbname = await _secureStorage.getDbname();
        final username = await _secureStorage.getUsername();
        
        if (dbname != null && username != null) {
          emit(AuthAuthenticated(
            token: token,
            username: username,
            dbname: dbname,
          ));
          
          // Automáticamente refrescar el token cuando se detecta que está autenticado
          add(AuthRefreshTokenRequested());
        } else {
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthRefreshTokenRequested(
    AuthRefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    // No cambiar el estado a loading si ya está autenticado, 
    // solo mostrar que está refrescando en background
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      emit(AuthTokenRefreshing());
    }

    try {
      // Obtener credenciales guardadas
      final username = await _secureStorage.getUsername();
      final password = await _secureStorage.getPassword();
      
      if (username == null || password == null) {
        emit(const AuthTokenRefreshFailed('Credenciales no encontradas'));
        return;
      }

      // Hacer login nuevamente para obtener token fresco
      final result = await _loginUseCase(LoginParams(
        username: username,
        password: password,
        numeroUnico: AppConstants.numeroUnico,
      ));

      result.fold(
        (failure) {
          emit(AuthTokenRefreshFailed(failure.message));
          // Si falla el refresh, cerrar sesión
          add(AuthLogoutRequested());
        },
        (newToken) {
          // Token refrescado exitosamente
          if (currentState is AuthAuthenticated) {
            emit(AuthAuthenticated(
              token: newToken,
              username: currentState.username,
              dbname: currentState.dbname,
            ));
          }
        },
      );
    } catch (e) {
      emit(AuthTokenRefreshFailed('Error al refrescar token: ${e.toString()}'));
      // Si hay error, cerrar sesión
      add(AuthLogoutRequested());
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Limpiar secure storage
      await _secureStorage.clearAll();
      
      // Limpiar shared preferences
      await _sharedPreferences.clear();
      
      emit(const AuthLoggedOut());
    } catch (e) {
      // En caso de error, aún así emitir logout
      emit(const AuthLoggedOut());
    }
  }

  void _onAuthLoginSuccess(
    AuthLoginSuccess event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthAuthenticated(
      token: event.token,
      username: event.username,
      dbname: event.dbname,
    ));
  }
}