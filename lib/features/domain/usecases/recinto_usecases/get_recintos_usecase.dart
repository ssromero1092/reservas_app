
import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/recinto.dart';
import 'package:reservas_app/features/domain/repositories/recinto_repository.dart';


class GetRecintosUseCase {
  final RecintoRepository recintoRepository;

  GetRecintosUseCase({required this.recintoRepository});

  Future<Either<Failure, List<Recinto>>> call() {
    return recintoRepository.getAll();
  }
}
