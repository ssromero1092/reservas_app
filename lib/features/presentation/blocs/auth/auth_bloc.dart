import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservas_app/core/constants/app_constants.dart';
import 'package:reservas_app/core/storage/secure_storage.dart';
import 'package:reservas_app/core/storage/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageRepository _secureStorage;
  final SharedPreferencesRepository _sharedPreferences;

  AuthBloc({
    required SecureStorageRepository secureStorage,
    required SharedPreferencesRepository sharedPreferences,
  }) : _secureStorage = secureStorage,
       _sharedPreferences = sharedPreferences,
       super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthLoginSuccess>(_onAuthLoginSuccess);
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