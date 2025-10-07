import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/features/data/models/cliente_model.dart';

abstract class ClienteRemoteDataSource {
  Future<Either<Failure, List<ClienteModel>>> getAll();
  Future<Either<Failure, Unit>> createCliente(String nombreCompleto, String rut, String telefono, String email);
  Future<Either<Failure, Unit>> updateCliente(int id, String nombreCompleto, String rut, String telefono, String email);
  Future<Either<Failure, Unit>> deleteCliente(int id);
}

class ClienteRemoteDataSourceImpl implements ClienteRemoteDataSource {
  final DioClient dioClient;
  static const String _clienteEndpoint = '/cliente';

  ClienteRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ClienteModel>>> getAll() async {
    try {
      final response = await dioClient.dio.get(_clienteEndpoint);
      if (response.statusCode == 200) {
        final list = (response.data['data'] as List)
            .map((jsonItem) => ClienteModel.fromJson(jsonItem))
            .toList();
        return Right(list);
      }
      return Left(ServerFailure(message: 'Error al obtener clientes'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createCliente(String nombreCompleto, String rut, String telefono, String email) async {
    try {
      final resp = await dioClient.dio.post(_clienteEndpoint, data: {
        'nombre_completo': nombreCompleto,
        'rut': rut,
        'telefono': telefono,
        'email': email,
      });
      return resp.statusCode == 201 
          ? const Right(unit) 
          : Left(ServerFailure(message: 'Error al crear cliente'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCliente(int id, String nombreCompleto, String rut, String telefono, String email) async {
    try {
      final resp = await dioClient.dio.put('$_clienteEndpoint/$id', data: {
        'nombre_completo': nombreCompleto,
        'rut': rut,
        'telefono': telefono,
        'email': email,
      });
      return resp.statusCode == 200 
          ? const Right(unit) 
          : Left(ServerFailure(message: 'Error al actualizar cliente'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCliente(int id) async {
    try {
      final resp = await dioClient.dio.delete('$_clienteEndpoint/$id');
      return resp.statusCode == 200 
          ? const Right(unit) 
          : Left(ServerFailure(message: 'Error al eliminar cliente'));
    } catch (e) {
      return Left(ServerFailure(message: 'Error: ${e.toString()}'));
    }
  }
}