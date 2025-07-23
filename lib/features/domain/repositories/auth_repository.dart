import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/Failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String numeroUnico, String password, String username);
}
