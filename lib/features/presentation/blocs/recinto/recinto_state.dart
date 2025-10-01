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
  final List<Recinto> filteredRecintos;
  final String searchQuery;

  const RecintoLoaded(
    this.recintos, {
    this.filteredRecintos = const [],
    this.searchQuery = '',
  });

  RecintoLoaded copyWith({
    List<Recinto>? recintos,
    List<Recinto>? filteredRecintos,
    String? searchQuery,
  }) {
    return RecintoLoaded(
      recintos ?? this.recintos,
      filteredRecintos: filteredRecintos ?? this.filteredRecintos,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Recinto> get displayList =>
      searchQuery.isEmpty ? recintos : filteredRecintos;

  @override
  List<Object?> get props => [recintos, filteredRecintos, searchQuery];
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