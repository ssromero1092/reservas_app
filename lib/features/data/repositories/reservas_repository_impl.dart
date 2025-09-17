import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/reservas_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/reserva.dart';
import 'package:reservas_app/features/domain/repositories/reservas_repository.dart';

class ReservasRepositoryImpl implements ReservasRepository{

    final ReservasRemoteDataSource remoteDataSource;

  ReservasRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Reserva>>> getReservas()  async {
     final resp =  await remoteDataSource.getReservas();

     return resp.fold(
      (failure) => Left(failure),
      (reservasList) => Right(reservasList),
    );

  }



}