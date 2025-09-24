import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/lista_precio_repository.dart';

class DeleteListaPrecioUseCase {
  final ListaPrecioRepository listaPrecioRepository;

  DeleteListaPrecioUseCase({required this.listaPrecioRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return listaPrecioRepository.delete(id);
  }
}