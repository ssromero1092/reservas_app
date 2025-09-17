import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/recinto_repository.dart';

class DeleteRecintoUseCase {
  final RecintoRepository recintoRepository;

  DeleteRecintoUseCase({required this.recintoRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return recintoRepository.delete(id);
  }
}