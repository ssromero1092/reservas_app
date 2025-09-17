import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/recinto_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';
import 'package:reservas_app/features/domain/repositories/recinto_repository.dart';

class RecintoRepositoryImpl implements RecintoRepository {
  final RecintoRemoteDataSource remoteDataSource;

  RecintoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Recinto>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> create(Recinto recinto) async {
    return await remoteDataSource.createRecinto(recinto.descripcion);
  }

  @override
  Future<Either<Failure, Unit>> update(Recinto recinto) async {
    return await remoteDataSource.updateRecinto(
      recinto.id,
      recinto.descripcion,
    );
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await remoteDataSource.deleteRecinto(id);
  }
}
