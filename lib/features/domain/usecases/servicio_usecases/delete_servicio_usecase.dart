import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/servicio_repository.dart';

class DeleteServicioUseCase {
  final ServicioRepository servicioRepository;

  DeleteServicioUseCase({required this.servicioRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return servicioRepository.delete(id);
  }
}