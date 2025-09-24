import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';

abstract class TipoHospedajeRepository {
  Future<Either<Failure, List<TipoHospedaje>>> getAll();
  Future<Either<Failure, Unit>> create(TipoHospedaje tipoHospedaje);
  Future<Either<Failure, Unit>> update(TipoHospedaje tipoHospedaje);
  Future<Either<Failure, Unit>> delete(int id);
}