import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/constants/app_constants.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/storage/secure_storage.dart';
import 'package:reservas_app/core/storage/shared_preferences.dart';
import 'package:reservas_app/features/data/datasources/auth_remote_data_source.dart';
import 'package:reservas_app/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageRepository secureStorage;
  final SharedPreferencesRepository sharedRepository;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
    required this.sharedRepository,
  });

  @override
  Future<Either<Failure, String>> login(String username, String password, String numeroUnico) async {
    try {
      final loginResponse = await remoteDataSource.login(
        username: username,
        password: password,
        numeroUnico: numeroUnico,
      );
      
      await secureStorage.saveToken(loginResponse.token);

      await secureStorage.saveDbname(loginResponse.dbname);
      
      await secureStorage.savePassword(password);

      await sharedRepository.setBool(
        AppConstants.cachedUsuarioKey,
        true,
      );

      await sharedRepository.setString(
        AppConstants.empresaKey,
        json.encode(loginResponse.empresa.toJson()),
      );
      
      return Right(username);
    } catch (e) {
      return Left(ServerFailure(message: 'Error durante el login: ${e.toString()}'));
    }
  }
}