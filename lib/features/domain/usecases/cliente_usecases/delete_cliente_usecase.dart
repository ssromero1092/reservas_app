import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/repositories/cliente_repository.dart';

class DeleteClienteUseCase {
  final ClienteRepository clienteRepository;

  DeleteClienteUseCase({required this.clienteRepository});

  Future<Either<Failure, Unit>> call(int id) {
    return clienteRepository.delete(id);
  }
}