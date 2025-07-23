class AppConstants {
  // Configuración de la aplicación
  static const String numeroUnico = "0015";
  static const String appName = "Reservas App";
  static const String appVersion = "1.0.0";
  
  // URLs y endpoints
  static const String baseUrl = "https://sistemaslh.cl/reservas/api/";

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 10);
  
  // Validaciones
  static const int minUsernameLength = 3;
  static const int minPasswordLength = 3;
  
  // Storage keys
  static const String authTokenKey = "auth_token";
  static const String dbnameKey = "dbname";
  static const String passwordKey = "password";
  static const String usernameKey = "username";
  static const String cachedUsuarioKey = "CACHED_USUARIO";
  static const String empresaKey = "EMPRESA";
}
