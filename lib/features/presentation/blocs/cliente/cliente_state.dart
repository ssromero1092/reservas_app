part of 'cliente_bloc.dart';

abstract class ClienteState extends Equatable {
  const ClienteState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class ClienteInitial extends ClienteState {}

/// Mostrando progreso
class ClienteLoading extends ClienteState {}

/// Lista cargada con éxito
class ClienteLoaded extends ClienteState {
  final List<Cliente> clientes;
  final List<Cliente> filteredClientes;
  final String searchQuery;

  const ClienteLoaded(
    this.clientes, {
    this.filteredClientes = const [],
    this.searchQuery = '',
  });

  ClienteLoaded copyWith({
    List<Cliente>? clientes,
    List<Cliente>? filteredClientes,
    String? searchQuery,
  }) {
    return ClienteLoaded(
      clientes ?? this.clientes,
      filteredClientes: filteredClientes ?? this.filteredClientes,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Cliente> get displayList =>
      searchQuery.isEmpty ? clientes : filteredClientes;

  @override
  List<Object?> get props => [clientes, filteredClientes, searchQuery];
}

/// Operación exitosa sin datos adicionales (ej. delete, update)
class ClienteSuccess extends ClienteState {
  final String message;

  const ClienteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error al ejecutar la acción
class ClienteError extends ClienteState {
  final String message;

  const ClienteError(this.message);

  @override
  List<Object?> get props => [message];
}