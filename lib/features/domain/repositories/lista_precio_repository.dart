import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';

abstract class ListaPrecioRepository {
  Future<Either<Failure, List<ListaPrecio>>> getAll();
  Future<Either<Failure, Unit>> create(ListaPrecio listaPrecio);
  Future<Either<Failure, Unit>> update(ListaPrecio listaPrecio);
  Future<Either<Failure, Unit>> delete(int id);
}