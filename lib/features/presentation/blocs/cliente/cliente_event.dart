part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object?> get props => [];
}

/// Cargar todos los clientes
class LoadClientes extends ClienteEvent {
  const LoadClientes();
}

/// Crear un nuevo cliente
class AddCliente extends ClienteEvent {
  final Cliente cliente;

  const AddCliente(this.cliente);

  @override
  List<Object?> get props => [cliente];
}

/// Actualizar un cliente existente
class UpdateCliente extends ClienteEvent {
  final Cliente cliente;

  const UpdateCliente(this.cliente);

  @override
  List<Object?> get props => [cliente];
}

/// Eliminar un cliente por ID
class DeleteCliente extends ClienteEvent {
  final int id;

  const DeleteCliente(this.id);

  @override
  List<Object?> get props => [id];
}

/// Buscar en la lista de clientes
class SearchClientes extends ClienteEvent {
  final String query;

  const SearchClientes(this.query);

  @override
  List<Object?> get props => [query];
}