import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/domain/repositories/cliente_repository.dart';

class UpdateClienteUseCase {
  final ClienteRepository clienteRepository;

  UpdateClienteUseCase({required this.clienteRepository});

  Future<Either<Failure, Unit>> call(Cliente cliente) {
    return clienteRepository.update(cliente);
  }
}