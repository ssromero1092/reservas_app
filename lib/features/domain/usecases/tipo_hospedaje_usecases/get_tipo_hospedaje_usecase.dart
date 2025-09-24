import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/domain/repositories/tipo_hospedaje_repository.dart';

class GetTipoHospedajesUseCase {
  final TipoHospedajeRepository tipoHospedajeRepository;

  GetTipoHospedajesUseCase({required this.tipoHospedajeRepository});

  Future<Either<Failure, List<TipoHospedaje>>> call() {
    return tipoHospedajeRepository.getAll();
  }
}