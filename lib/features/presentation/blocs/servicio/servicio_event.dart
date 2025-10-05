part of 'servicio_bloc.dart';

abstract class ServicioEvent extends Equatable {
  const ServicioEvent();

  @override
  List<Object?> get props => [];
}

class LoadServicios extends ServicioEvent {
  const LoadServicios();
}

class AddServicio extends ServicioEvent {
  final Servicio servicio;
  const AddServicio(this.servicio);
  @override
  List<Object?> get props => [servicio];
}

class UpdateServicio extends ServicioEvent {
  final Servicio servicio;
  const UpdateServicio(this.servicio);
  @override
  List<Object?> get props => [servicio];
}

class DeleteServicio extends ServicioEvent {
  final int id;
  const DeleteServicio(this.id);
  @override
  List<Object?> get props => [id];
}

class SearchServicios extends ServicioEvent {
  final String query;
  const SearchServicios(this.query);
  @override
  List<Object?> get props => [query];
}