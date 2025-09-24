import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';

import '../models/tipo_hospedaje_model.dart';

abstract class TipoHospedajeRemoteDataSource {
  Future<Either<Failure, List<TipoHospedajeModel>>> getAll();
  Future<Either<Failure, Unit>> createTipoHospedaje(String descripcion, String equipamiento);
  Future<Either<Failure, Unit>> updateTipoHospedaje(int id, String descripcion, String equipamiento);
  Future<Either<Failure, Unit>> deleteTipoHospedaje(int id);
}

class TipoHospedajeRemoteDataSourceImpl implements TipoHospedajeRemoteDataSource {
  final DioClient dioClient;
  static const String _tipoHospedajeEndpoint = '/tipohospedaje';

  TipoHospedajeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<TipoHospedajeModel>>> getAll() async {
    try {
      final response = await dioClient.dio.get(
        _tipoHospedajeEndpoint
      );

      if (response.statusCode == 200) {
        final list = (response.data['data'] as List)
            .map((jsonItem) => TipoHospedajeModel.fromJson(jsonItem))
            .toList();
        return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener tipos de hospedaje'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createTipoHospedaje(String descripcion, String equipamiento) async {
    try {
      final resp = await dioClient.dio.post(_tipoHospedajeEndpoint,
          data: {
            'descripcion': descripcion,
            'equipamiento': equipamiento,
          });
      log('Create tipo hospedaje response: ${resp.statusCode}', name: 'TipoHospedajeRemoteDataSource');
      return resp.statusCode == 201 ? const Right(unit) : Left(ServerFailure(message: 'Error al crear tipo de hospedaje'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTipoHospedaje(int id, String descripcion, String equipamiento) async {
    try {
      final resp = await dioClient.dio.put('$_tipoHospedajeEndpoint/$id',
          data: {
            'descripcion': descripcion,
            'equipamiento': equipamiento,
          });
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al actualizar tipo de hospedaje'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTipoHospedaje(int id) async {
    try {
      final resp = await dioClient.dio.delete('$_tipoHospedajeEndpoint/$id');
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al eliminar tipo de hospedaje'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }
}