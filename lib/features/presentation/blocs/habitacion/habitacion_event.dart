
part of 'habitacion_bloc.dart';

abstract class HabitacionEvent extends Equatable {
  const HabitacionEvent();

  @override
  List<Object?> get props => [];
}

/// Cargar todas las habitaciones
class LoadHabitaciones extends HabitacionEvent {
  const LoadHabitaciones();
}

/// Crear una nueva habitación
class AddHabitacion extends HabitacionEvent {
  final Habitacion habitacion;

  const AddHabitacion(this.habitacion);

  @override
  List<Object?> get props => [habitacion];
}

/// Actualizar una habitación existente
class UpdateHabitacion extends HabitacionEvent {
  final Habitacion habitacion;

  const UpdateHabitacion(this.habitacion);

  @override
  List<Object?> get props => [habitacion];
}

/// Eliminar una habitación por ID
class DeleteHabitacion extends HabitacionEvent {
  final int id;

  const DeleteHabitacion(this.id);

  @override
  List<Object?> get props => [id];
}

/// Buscar en la lista de habitaciones
class SearchHabitaciones extends HabitacionEvent {
  final String query;

  const SearchHabitaciones(this.query);

  @override
  List<Object?> get props => [query];
}