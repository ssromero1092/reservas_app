import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/servicio.dart';
import 'package:reservas_app/features/domain/repositories/servicio_repository.dart';

class UpdateServicioUseCase {
  final ServicioRepository servicioRepository;

  UpdateServicioUseCase({required this.servicioRepository});

  Future<Either<Failure, Unit>> call(Servicio servicio) {
    return servicioRepository.update(servicio);
  }
}