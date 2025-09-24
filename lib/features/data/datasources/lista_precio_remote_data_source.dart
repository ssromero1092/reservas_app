import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';

import '../models/lista_precio_model.dart';

abstract class ListaPrecioRemoteDataSource {
  Future<Either<Failure, List<ListaPrecioModel>>> getAll();
  Future<Either<Failure, Unit>> createListaPrecio(int valor, int idTipoHospedaje, int idTipoPrecio);
  Future<Either<Failure, Unit>> updateListaPrecio(int id, int valor, int idTipoHospedaje, int idTipoPrecio);
  Future<Either<Failure, Unit>> deleteListaPrecio(int id);
}

class ListaPrecioRemoteDataSourceImpl implements ListaPrecioRemoteDataSource {
  final DioClient dioClient;
  static const String _listaPrecioEndpoint = '/listaprecio';

  ListaPrecioRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ListaPrecioModel>>> getAll() async {
    try {
      final response = await dioClient.dio.post(
        '$_listaPrecioEndpoint/advance',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final list = data.map((json) => ListaPrecioModel.fromJson(json)).toList();
        return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener lista de precios'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createListaPrecio(int valor, int idTipoHospedaje, int idTipoPrecio) async {
    try {
      final resp = await dioClient.dio.post(_listaPrecioEndpoint,
        data: {
          'valor': valor,
          'id_tipo_hospedaje': idTipoHospedaje,
          'id_tipo_precio': idTipoPrecio,
        });
      log('Create lista precio response: ${resp.statusCode}', name: 'ListaPrecioRemoteDataSource');
      return resp.statusCode == 201 ? const Right(unit) : Left(ServerFailure(message: 'Error al crear lista de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateListaPrecio(int id, int valor, int idTipoHospedaje, int idTipoPrecio) async {
    try {
      final resp = await dioClient.dio.put('$_listaPrecioEndpoint/$id',
        data: {
          'valor': valor,
          'id_tipo_hospedaje': idTipoHospedaje,
          'id_tipo_precio': idTipoPrecio,
        });
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al actualizar lista de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteListaPrecio(int id) async {
    try {
      final resp = await dioClient.dio.delete('$_listaPrecioEndpoint/$id');
      return resp.statusCode == 200 ? const Right(unit) : Left(ServerFailure(message: 'Error al eliminar lista de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }
}