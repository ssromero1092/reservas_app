import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/tipo_precio_repository.dart';

class DeleteTipoPrecioUseCase {
  final TipoPrecioRepository tipoPrecioRepository;

  DeleteTipoPrecioUseCase({required this.tipoPrecioRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return tipoPrecioRepository.deleteTipoPrecio(id);
  }
}
