import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/reserva.dart';
import 'package:reservas_app/features/domain/repositories/reservas_repository.dart';

class ReservasAdvanceUseCase {
  final ReservasRepository reservasRepository;

  ReservasAdvanceUseCase({required this.reservasRepository});

  Future<Either<Failure, List<Reserva>>> call() {
    return reservasRepository.getReservas();
  }
}