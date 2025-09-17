part of 'recinto_bloc.dart';

abstract class RecintoState extends Equatable {
  const RecintoState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class RecintoInitial extends RecintoState {}

/// Mostrando progreso
class RecintoLoading extends RecintoState {}

/// Lista cargada con éxito
class RecintoLoaded extends RecintoState {
  final List<Recinto> recintos;

  const RecintoLoaded(this.recintos);

  @override
  List<Object?> get props => [recintos];
}

/// Operación exitosa sin datos adicionales (ej. delete, update)
class RecintoSuccess extends RecintoState {
  final String message;

  const RecintoSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error al ejecutar la acción
class RecintoError extends RecintoState {
  final String message;

  const RecintoError(this.message);

  @override
  List<Object?> get props => [message];
}
