
import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/domain/repositories/habitacion_repository.dart';

class GetHabitacionesUseCase {
  final HabitacionRepository habitacionRepository;

  GetHabitacionesUseCase({required this.habitacionRepository});

  Future<Either<Failure, List<Habitacion>>> call() {
    return habitacionRepository.getAll();
  }
}
