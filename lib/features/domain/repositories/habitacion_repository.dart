import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';

abstract class HabitacionRepository {
  Future<Either<Failure, List<Habitacion>>> getAll();
  Future<Either<Failure, Unit>> create(Habitacion habitacion);
  Future<Either<Failure, Unit>> update(Habitacion habitacion);
  Future<Either<Failure, Unit>> delete(int id);
}