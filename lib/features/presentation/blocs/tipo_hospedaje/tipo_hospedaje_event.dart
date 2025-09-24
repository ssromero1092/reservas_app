part of 'tipo_hospedaje_bloc.dart';

abstract class TipoHospedajeEvent extends Equatable {
  const TipoHospedajeEvent();

  @override
  List<Object?> get props => [];
}

/// Cargar todos los tipos de hospedaje
class LoadTipoHospedajes extends TipoHospedajeEvent {
  const LoadTipoHospedajes();
}

/// Crear un nuevo tipo de hospedaje
class AddTipoHospedaje extends TipoHospedajeEvent {
  final TipoHospedaje tipoHospedaje;

  const AddTipoHospedaje(this.tipoHospedaje);

  @override
  List<Object?> get props => [tipoHospedaje];
}

/// Actualizar un tipo de hospedaje existente
class UpdateTipoHospedaje extends TipoHospedajeEvent {
  final TipoHospedaje tipoHospedaje;

  const UpdateTipoHospedaje(this.tipoHospedaje);

  @override
  List<Object?> get props => [tipoHospedaje];
}

/// Eliminar un tipo de hospedaje por ID
class DeleteTipoHospedaje extends TipoHospedajeEvent {
  final int id;

  const DeleteTipoHospedaje(this.id);

  @override
  List<Object?> get props => [id];
}