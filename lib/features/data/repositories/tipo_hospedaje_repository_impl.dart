import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/tipo_hospedaje_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/domain/repositories/tipo_hospedaje_repository.dart';

class TipoHospedajeRepositoryImpl implements TipoHospedajeRepository {
  final TipoHospedajeRemoteDataSource remoteDataSource;

  TipoHospedajeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TipoHospedaje>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> create(TipoHospedaje tipoHospedaje) async {
    return await remoteDataSource.createTipoHospedaje(
      tipoHospedaje.descripcion,
      tipoHospedaje.equipamiento,
    );
  }

  @override
  Future<Either<Failure, Unit>> update(TipoHospedaje tipoHospedaje) async {
    return await remoteDataSource.updateTipoHospedaje(
      tipoHospedaje.idTipoHospedaje,
      tipoHospedaje.descripcion,
      tipoHospedaje.equipamiento,
    );
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await remoteDataSource.deleteTipoHospedaje(id);
  }
}