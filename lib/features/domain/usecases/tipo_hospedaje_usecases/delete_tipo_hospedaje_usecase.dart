import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/tipo_hospedaje_repository.dart';

class DeleteTipoHospedajeUseCase {
  final TipoHospedajeRepository tipoHospedajeRepository;

  DeleteTipoHospedajeUseCase({required this.tipoHospedajeRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return tipoHospedajeRepository.delete(id);
  }
}