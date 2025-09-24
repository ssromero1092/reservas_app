import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/tipo_precio_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';
import 'package:reservas_app/features/domain/repositories/tipo_precio_repository.dart';

class TipoPrecioRepositoryImpl implements TipoPrecioRepository {
  final TipoPrecioRemoteDataSource remoteDataSource;

  TipoPrecioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TipoPrecio>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> createTipoPrecio(TipoPrecio tipoPrecio) async {
    return await remoteDataSource.createTipoPrecio(
      tipoPrecio.descripcion,
      tipoPrecio.observacion,
    );
  }

  @override
  Future<Either<Failure, Unit>> updateTipoPrecio(TipoPrecio tipoPrecio) async {
    return await remoteDataSource.updateTipoPrecio(
      tipoPrecio.idTipoPrecio,
      tipoPrecio.descripcion,
      tipoPrecio.observacion,
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteTipoPrecio(int id) async {
    return await remoteDataSource.deleteTipoPrecio(id);
  }
}
