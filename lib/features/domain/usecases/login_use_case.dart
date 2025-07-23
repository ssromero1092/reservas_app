import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/Failure.dart';
import 'package:reservas_app/features/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, String>> call(LoginParams params) async {
    return await repository.login(
      params.username,
      params.password,
      params.numeroUnico,
    );
  }
}

class LoginParams {
  final String username;
  final String password;
  final String numeroUnico;

  LoginParams({
    required this.username,
    required this.password,
    required this.numeroUnico,
  });
}
