// lib/features/recinto/data/datasources/recinto_remote_data_source.dart
import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';

import '../models/recinto_model.dart';

abstract class RecintoRemoteDataSource {
  Future<Either<Failure, List<RecintoModel>>> getAll();
  Future<Either<Failure, Unit>> createRecinto(String descripcion);
  Future<Either<Failure, Unit>> updateRecinto(int id, String descripcion);
  Future<Either<Failure, Unit>> deleteRecinto(int id);
}

class RecintoRemoteDataSourceImpl implements RecintoRemoteDataSource {
  final DioClient dioClient;
  static const String _recintoEndpoint = '/recinto';

  RecintoRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<RecintoModel>>> getAll() async {
    try {
      final response = await dioClient.dio.get(_recintoEndpoint);
      if (response.statusCode == 200) {
        final list = (response.data['data'] as List)
            .map((jsonItem) => RecintoModel.fromJson(jsonItem))
            .toList();
        return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener recintos'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createRecinto(String descripcion) async {
    try {
      final resp = await dioClient.dio.post(_recintoEndpoint, data: {'descripcion': descripcion});
      return resp.statusCode == 201 ? const Right(unit) : Left(ServerFailure(message: 'Error al crear recinto'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateRecinto(int id, String descripcion) async {
    try {
      final resp = await dioClient.dio.put('$_recintoEndpoint/$id', data: {'descripcion': descripcion});
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al actualizar recinto'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRecinto(int id) async {
    try {
      final resp = await dioClient.dio.delete('$_recintoEndpoint/$id');
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al eliminar recinto'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
