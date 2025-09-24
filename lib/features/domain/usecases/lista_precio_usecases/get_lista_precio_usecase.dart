import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';
import 'package:reservas_app/features/domain/repositories/lista_precio_repository.dart';

class GetListaPreciosUseCase {
  final ListaPrecioRepository listaPrecioRepository;

  GetListaPreciosUseCase({required this.listaPrecioRepository});

  Future<Either<Failure, List<ListaPrecio>>> call() {
    return listaPrecioRepository.getAll();
  }
}