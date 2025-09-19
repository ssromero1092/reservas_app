import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/habitacion_repository.dart';

class DeleteHabitacionUseCase {
  final HabitacionRepository habitacionRepository;

  DeleteHabitacionUseCase({required this.habitacionRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return habitacionRepository.delete(id);
  }
}