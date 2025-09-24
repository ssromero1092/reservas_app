import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';
import 'package:reservas_app/features/domain/repositories/tipo_precio_repository.dart';

class CreateTipoPrecioUseCase {
  final TipoPrecioRepository tipoPrecioRepository;

  CreateTipoPrecioUseCase({required this.tipoPrecioRepository});

  Future<Either<Failure, Unit>> call(TipoPrecio tipoPrecio) {
    return tipoPrecioRepository.createTipoPrecio(tipoPrecio);
  }
}
