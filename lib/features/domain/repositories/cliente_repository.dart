import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';

abstract class ClienteRepository {
  Future<Either<Failure, List<Cliente>>> getAll();
  Future<Either<Failure, Unit>> create(Cliente cliente);
  Future<Either<Failure, Unit>> update(Cliente cliente);
  Future<Either<Failure, Unit>> delete(int id);
}