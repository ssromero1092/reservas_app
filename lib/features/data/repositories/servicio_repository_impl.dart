import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/servicio_remote_data_source.dart';
import 'package:reservas_app/features/data/models/servicio_model.dart';
import 'package:reservas_app/features/domain/entities/servicio.dart';
import 'package:reservas_app/features/domain/repositories/servicio_repository.dart';

class ServicioRepositoryImpl implements ServicioRepository {
  final ServicioRemoteDataSource remoteDataSource;

  ServicioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Servicio>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> create(Servicio servicio) async {
    final servicioModel = ServicioModel(
      idServicio: servicio.idServicio,
      descripcion: servicio.descripcion,
      valorReferencial: servicio.valorReferencial,
      observacion: servicio.observacion,
    );
    return await remoteDataSource.createServicio(servicioModel);
  }

  @override
  Future<Either<Failure, Unit>> update(Servicio servicio) async {
    final servicioModel = ServicioModel(
      idServicio: servicio.idServicio,
      descripcion: servicio.descripcion,
      valorReferencial: servicio.valorReferencial,
      observacion: servicio.observacion,
    );
    return await remoteDataSource.updateServicio(servicioModel);
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await remoteDataSource.deleteServicio(id);
  }
}