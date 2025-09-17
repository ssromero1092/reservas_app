

import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';

abstract class RecintoRepository {
  Future<Either<Failure, List<Recinto>>> getAll();
  Future<Either<Failure, Unit>> create(Recinto recinto);
  Future<Either<Failure, Unit>> update(Recinto recinto);
  Future<Either<Failure, Unit>> delete(int id);
  
}