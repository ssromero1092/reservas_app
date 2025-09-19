import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/domain/repositories/habitacion_repository.dart';

class CreateHabitacionUseCase {
  final HabitacionRepository habitacionRepository;

  CreateHabitacionUseCase({required this.habitacionRepository});

  Future<Either<Failure, Unit>> call(Habitacion habitacion) {
    return habitacionRepository.create(habitacion);
  }
}