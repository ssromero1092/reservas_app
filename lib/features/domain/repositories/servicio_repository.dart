import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/servicio.dart';

abstract class ServicioRepository {
  Future<Either<Failure, List<Servicio>>> getAll();
  Future<Either<Failure, Unit>> create(Servicio servicio);
  Future<Either<Failure, Unit>> update(Servicio servicio);
  Future<Either<Failure, Unit>> delete(int id);
}