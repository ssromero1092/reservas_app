import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/cliente_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final ClienteRemoteDataSource remoteDataSource;

  ClienteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Cliente>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> create(Cliente cliente) async {
    return await remoteDataSource.createCliente(
      cliente.nombreCompleto,
      cliente.rut,
      cliente.telefono,
      cliente.email,
    );
  }

  @override
  Future<Either<Failure, Unit>> update(Cliente cliente) async {
    return await remoteDataSource.updateCliente(
      cliente.idCliente,
      cliente.nombreCompleto,
      cliente.rut,
      cliente.telefono,
      cliente.email,
    );
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await remoteDataSource.deleteCliente(id);
  }
}