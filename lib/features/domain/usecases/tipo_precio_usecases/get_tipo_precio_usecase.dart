import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';
import 'package:reservas_app/features/domain/repositories/tipo_precio_repository.dart';

class GetTipoPreciosUseCase {
  final TipoPrecioRepository tipoPrecioRepository;

  GetTipoPreciosUseCase({required this.tipoPrecioRepository});

  Future<Either<Failure, List<TipoPrecio>>> call() {
    return tipoPrecioRepository.getAll();
  }
}
