part of 'tipo_hospedaje_bloc.dart';

abstract class TipoHospedajeState extends Equatable {
  const TipoHospedajeState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class TipoHospedajeInitial extends TipoHospedajeState {}

/// Mostrando progreso
class TipoHospedajeLoading extends TipoHospedajeState {}

/// Lista cargada con éxito
class TipoHospedajeLoaded extends TipoHospedajeState {
  final List<TipoHospedaje> tipoHospedajes;
  final List<TipoHospedaje> filteredTipoHospedajes;
  final String searchQuery;

  const TipoHospedajeLoaded(
    this.tipoHospedajes, {
    this.filteredTipoHospedajes = const [],
    this.searchQuery = '',
  });

  TipoHospedajeLoaded copyWith({
    List<TipoHospedaje>? tipoHospedajes,
    List<TipoHospedaje>? filteredTipoHospedajes,
    String? searchQuery,
  }) {
    return TipoHospedajeLoaded(
      tipoHospedajes ?? this.tipoHospedajes,
      filteredTipoHospedajes: filteredTipoHospedajes ?? this.filteredTipoHospedajes,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<TipoHospedaje> get displayList =>
      searchQuery.isEmpty ? tipoHospedajes : filteredTipoHospedajes;

  @override
  List<Object?> get props => [tipoHospedajes, filteredTipoHospedajes, searchQuery];
}

/// Operación exitosa sin datos adicionales (ej. delete, update)
class TipoHospedajeSuccess extends TipoHospedajeState {
  final String message;

  const TipoHospedajeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error al ejecutar la acción
class TipoHospedajeError extends TipoHospedajeState {
  final String message;

  const TipoHospedajeError(this.message);

  @override
  List<Object?> get props => [message];
}