
import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/habitacion_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/domain/repositories/habitacion_repository.dart';

class HabitacionRepositoryImpl implements HabitacionRepository {
  final HabitacionRemoteDataSource remoteDataSource;

  HabitacionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Habitacion>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> create(Habitacion habitacion) async {
    return await remoteDataSource.createHabitacion(
      habitacion.descripcion,
      habitacion.capacidad,
      habitacion.idRecinto,
    );
  }

  @override
  Future<Either<Failure, Unit>> update(Habitacion habitacion) async {
    return await remoteDataSource.updateHabitacion(
      habitacion.idHabitacion,
      habitacion.descripcion,
      habitacion.capacidad,
      habitacion.idRecinto,
    );
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await remoteDataSource.deleteHabitacion(id);
  }
}