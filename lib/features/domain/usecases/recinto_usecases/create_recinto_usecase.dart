import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';
import 'package:reservas_app/features/domain/repositories/recinto_repository.dart';

class CreateRecintoUseCase {
  final RecintoRepository recintoRepository;

  CreateRecintoUseCase({required this.recintoRepository});

  Future<Either<Failure, Unit>> call(Recinto recinto) {
    return recintoRepository.create(recinto);
  }
}


// UpdateRecintoUseCase
// DeleteRecintoUseCase