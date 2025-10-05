import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/features/data/models/servicio_model.dart';

abstract class ServicioRemoteDataSource {
  Future<Either<Failure, List<ServicioModel>>> getAll();
  Future<Either<Failure, Unit>> createServicio(ServicioModel servicio);
  Future<Either<Failure, Unit>> updateServicio(ServicioModel servicio);
  Future<Either<Failure, Unit>> deleteServicio(int id);
}

class ServicioRemoteDataSourceImpl implements ServicioRemoteDataSource {
  final DioClient dioClient;
  static const String _servicioEndpoint = '/servicio';

  ServicioRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ServicioModel>>> getAll() async {
    try {
      final response = await dioClient.dio.get(_servicioEndpoint);
      if (response.statusCode == 200) {
        final list = (response.data['data'] as List)
            .map((jsonItem) => ServicioModel.fromJson(jsonItem))
            .toList();
        return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener servicios'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createServicio(ServicioModel servicio) async {
    try {
      final resp = await dioClient.dio.post(_servicioEndpoint, data: {
        'descripcion': servicio.descripcion,
        'valor_referencial': servicio.valorReferencial,
        'observacion': servicio.observacion,
      });
      return resp.statusCode == 201
          ? const Right(unit)
          : Left(ServerFailure(message: 'Error al crear servicio'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateServicio(ServicioModel servicio) async {
    try {
      final resp = await dioClient.dio
          .put('$_servicioEndpoint/${servicio.idServicio}', data: {
        'descripcion': servicio.descripcion,
        'valor_referencial': servicio.valorReferencial,
        'observacion': servicio.observacion,
      });
      return resp.statusCode == 200
          ? const Right(unit)
          : Left(ServerFailure(message: 'Error al actualizar servicio'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteServicio(int id) async {
    try {
      final resp = await dioClient.dio.delete('$_servicioEndpoint/$id');
      return resp.statusCode == 200
          ? const Right(unit)
          : Left(ServerFailure(message: 'Error al eliminar servicio'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}