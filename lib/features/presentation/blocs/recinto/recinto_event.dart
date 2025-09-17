part of 'recinto_bloc.dart';


abstract class RecintoEvent extends Equatable {
  const RecintoEvent();

  @override
  List<Object?> get props => [];
}

/// Cargar todos los recintos
class LoadRecintos extends RecintoEvent {
  const LoadRecintos();
}

/// Crear un nuevo recinto
class AddRecinto extends RecintoEvent {
  final Recinto recinto;

  const AddRecinto(this.recinto);

  @override
  List<Object?> get props => [recinto];
}

/// Actualizar un recinto existente
class UpdateRecinto extends RecintoEvent {
  final Recinto recinto;

  const UpdateRecinto(this.recinto);

  @override
  List<Object?> get props => [recinto];
}

/// Eliminar un recinto por ID
class DeleteRecinto extends RecintoEvent {
  final int id;

  const DeleteRecinto(this.id);

  @override
  List<Object?> get props => [id];
}
