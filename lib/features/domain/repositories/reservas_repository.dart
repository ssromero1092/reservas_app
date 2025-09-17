import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/reserva.dart';

abstract class ReservasRepository{
  Future<Either<Failure, List<Reserva>>> getReservas();
  /*
  Future<Either<Failure, Reserva>> getReservaById(String id);
  
  Future<Either<Failure, String>> createReserva(Reserva reserva);
  
  Future<Either<Failure, String>> updateReserva(Reserva reserva);
  
  Future<Either<Failure, String>> deleteReserva(String id);
  */
}