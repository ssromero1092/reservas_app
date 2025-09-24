import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/features/data/models/tipo_precio_model.dart';

abstract class TipoPrecioRemoteDataSource {
  Future<Either<Failure, List<TipoPrecioModel>>> getAll();
  Future<Either<Failure, Unit>> createTipoPrecio(String descripcion, String observacion);
  Future<Either<Failure, Unit>> updateTipoPrecio(int id, String descripcion, String observacion);
  Future<Either<Failure, Unit>> deleteTipoPrecio(int id);
}

class TipoPrecioRemoteDataSourceImpl implements TipoPrecioRemoteDataSource {
  final DioClient dioClient;
  static const String _tipoPrecioEndpoint = '/tipoprecio';

  TipoPrecioRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<TipoPrecioModel>>> getAll() async {
    try {
      final response = await dioClient.dio.get(_tipoPrecioEndpoint);
      if (response.statusCode == 200) {
        final list = (response.data['data'] as List)
            .map((jsonItem) => TipoPrecioModel.fromJson(jsonItem))
            .toList();
        return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener tipos de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createTipoPrecio(String descripcion, String observacion) async {
    try {
      final response = await dioClient.dio.post(_tipoPrecioEndpoint, data: {
        'descripcion': descripcion,
        'observacion': observacion,
      });
      return response.statusCode == 201 ? const Right(unit) : Left(ServerFailure(message: 'Error al crear tipo de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTipoPrecio(int id, String descripcion, String observacion) async {
    try {
      final response = await dioClient.dio.put('$_tipoPrecioEndpoint/$id', data: {
        'descripcion': descripcion,
        'observacion': observacion,
      });
      return response.statusCode == 200
          ? const Right(unit)
          : Left(ServerFailure(message: 'Error al actualizar tipo de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTipoPrecio(int id) async {
    try {
      final response = await dioClient.dio.delete('$_tipoPrecioEndpoint/$id');
      return response.statusCode == 200
          ? const Right(unit)
          : Left(ServerFailure(message: 'Error al eliminar tipo de precio'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }
}
