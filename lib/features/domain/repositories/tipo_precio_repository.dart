import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';

abstract class TipoPrecioRepository {
  Future<Either<Failure, List<TipoPrecio>>> getAll();
  Future<Either<Failure, Unit>> createTipoPrecio(TipoPrecio tipoPrecio);
  Future<Either<Failure, Unit>> updateTipoPrecio(TipoPrecio tipoPrecio);
  Future<Either<Failure, Unit>> deleteTipoPrecio(int id);
}
