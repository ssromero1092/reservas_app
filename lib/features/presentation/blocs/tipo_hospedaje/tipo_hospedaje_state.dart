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

  const TipoHospedajeLoaded(this.tipoHospedajes);

  @override
  List<Object?> get props => [tipoHospedajes];
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