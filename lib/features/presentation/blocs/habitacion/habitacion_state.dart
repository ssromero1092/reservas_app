
part of 'habitacion_bloc.dart';

abstract class HabitacionState extends Equatable {
  const HabitacionState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class HabitacionInitial extends HabitacionState {}

/// Mostrando progreso
class HabitacionLoading extends HabitacionState {}

/// Lista cargada con éxito
class HabitacionLoaded extends HabitacionState {
  final List<Habitacion> habitaciones;
  final List<Habitacion> filteredHabitaciones;
  final String searchQuery;

  const HabitacionLoaded(
    this.habitaciones, {
    this.filteredHabitaciones = const [],
    this.searchQuery = '',
  });

  HabitacionLoaded copyWith({
    List<Habitacion>? habitaciones,
    List<Habitacion>? filteredHabitaciones,
    String? searchQuery,
  }) {
    return HabitacionLoaded(
      habitaciones ?? this.habitaciones,
      filteredHabitaciones: filteredHabitaciones ?? this.filteredHabitaciones,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Habitacion> get displayList =>
      searchQuery.isEmpty ? habitaciones : filteredHabitaciones;

  @override
  List<Object?> get props => [habitaciones, filteredHabitaciones, searchQuery];
}

/// Operación exitosa sin datos adicionales (ej. delete, update)
class HabitacionSuccess extends HabitacionState {
  final String message;

  const HabitacionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error al ejecutar la acción
class HabitacionError extends HabitacionState {
  final String message;

  const HabitacionError(this.message);

  @override
  List<Object?> get props => [message];
}