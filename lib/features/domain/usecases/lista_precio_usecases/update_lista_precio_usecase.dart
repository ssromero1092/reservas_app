import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';
import 'package:reservas_app/features/domain/repositories/lista_precio_repository.dart';

class UpdateListaPrecioUseCase {
  final ListaPrecioRepository listaPrecioRepository;

  UpdateListaPrecioUseCase({required this.listaPrecioRepository});

  Future<Either<Failure, Unit>> call(ListaPrecio listaPrecio) {
    return listaPrecioRepository.update(listaPrecio);
  }
}