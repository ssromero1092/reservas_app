
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';

import '../models/habitacion_model.dart';

abstract class HabitacionRemoteDataSource {
  Future<Either<Failure, List<HabitacionModel>>> getAll();
  Future<Either<Failure, Unit>> createHabitacion(String descripcion, String capacidad, int idRecinto);
  Future<Either<Failure, Unit>> updateHabitacion(int id, String descripcion, String capacidad, int idRecinto);
  Future<Either<Failure, Unit>> deleteHabitacion(int id);
}

class HabitacionRemoteDataSourceImpl implements HabitacionRemoteDataSource {
  final DioClient dioClient;
  static const String _habitacionEndpoint = '/habitacion';

  HabitacionRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<HabitacionModel>>> getAll() async {
    try {
      final response = await dioClient.dio.post(
        '$_habitacionEndpoint/advance',
        data: {},
      );

      if (response.statusCode == 200) {
        final  list = (response.data['data'] as List)
          .map((jsonItem) => HabitacionModel.fromJson(jsonItem))
          .toList();
      return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener recintos'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createHabitacion(String descripcion, String capacidad, int idRecinto) async {
    try {
      
      final resp = await dioClient.dio.post(_habitacionEndpoint,
      data: {
        'descripcion': descripcion,
        'capacidad': capacidad,
        'id_recinto': idRecinto,
      });
      log('Create habitacion response: ${resp.statusCode}', name: 'HabitacionRemoteDataSource');
      return resp.statusCode == 201 ? const Right(unit) : Left(ServerFailure(message: 'Error al crear habitacion'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHabitacion(int id, String descripcion, String capacidad, int idRecinto) async {
    try {
      final resp = await dioClient.dio.put('$_habitacionEndpoint/$id',
      data: {
        'descripcion': descripcion,
        'capacidad': capacidad,
        'id_recinto': idRecinto,
      });
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al actualizar habitacion'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteHabitacion(int id) async {
    try {
      final resp = await dioClient.dio.delete('$_habitacionEndpoint/$id');
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al eliminar habitacion'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }
}