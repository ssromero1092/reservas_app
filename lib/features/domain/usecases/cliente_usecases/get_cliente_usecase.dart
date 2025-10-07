import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/domain/repositories/cliente_repository.dart';

class GetClientesUseCase {
  final ClienteRepository clienteRepository;

  GetClientesUseCase({required this.clienteRepository});

  Future<Either<Failure, List<Cliente>>> call() {
    return clienteRepository.getAll();
  }
}