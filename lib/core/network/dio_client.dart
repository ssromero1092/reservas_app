import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:reservas_app/core/storage/secure_storage_repository.dart';

class DioClient {
  final Dio dio;
  final Logger logger;
  final SecureStorageRepository secureStorage;

  DioClient({
    required this.dio,
    required this.logger,
    required this.secureStorage,
  }) {
    // Configuración base de Dio
    dio.options = BaseOptions(
      baseUrl: 'https://sistemaslh.cl/apr/api/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    // Interceptores
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.getToken();
          final dbname = await secureStorage.getDbname();

          options.headers.addAll({
            'Content-Type': 'application/json; charset=UTF-8',
            'Connection': 'close',
            'Accept-Encoding': 'gzip',
            'User-Agent': 'Mozilla/5.0',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
            if (dbname != null && dbname.isNotEmpty) 'dbname': dbname,
          });
          logger.i('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d('Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }
}
