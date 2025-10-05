import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/servicio.dart';
import 'package:reservas_app/features/domain/repositories/servicio_repository.dart';

class GetServiciosUseCase {
  final ServicioRepository servicioRepository;

  GetServiciosUseCase({required this.servicioRepository});

  Future<Either<Failure, List<Servicio>>> call() {
    return servicioRepository.getAll();
  }
}