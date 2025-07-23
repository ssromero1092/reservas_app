import 'package:reservas_app/core/errors/backend_errors.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/features/data/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String username,
    required String password,
    required String numeroUnico,
  });

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  static const String _loginEndpoint = '/auth/login';

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginResponseModel> login({
    required String username,
    required String password,
    required String numeroUnico,
  }) async {
    final response = await dioClient.dio.post(
      _loginEndpoint,
      data: {
        'username': username,
        'password': password,
        'numero_unico': numeroUnico,
      },
    );

    if (response.statusCode != 200) {
      switch (response.statusCode) {
        case 204:
          throw const NoContentResponse(
            'El nombre de usuario o clave ingresadas no se reconocen.',
          );
        case 104:
          throw RequestReachedException();
        case 201:
          throw InvalidBaseCurrency();
        default:
          throw Exception();
      }
    }
    return LoginResponseModel.fromJson(response.data);
  }
}  