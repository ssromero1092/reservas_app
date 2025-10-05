part of 'servicio_bloc.dart';

abstract class ServicioState extends Equatable {
  const ServicioState();

  @override
  List<Object?> get props => [];
}

class ServicioInitial extends ServicioState {}

class ServicioLoading extends ServicioState {}

class ServicioLoaded extends ServicioState {
  final List<Servicio> servicios;
  final List<Servicio> filteredServicios;
  final String searchQuery;

  const ServicioLoaded(
    this.servicios, {
    this.filteredServicios = const [],
    this.searchQuery = '',
  });

  ServicioLoaded copyWith({
    List<Servicio>? servicios,
    List<Servicio>? filteredServicios,
    String? searchQuery,
  }) {
    return ServicioLoaded(
      servicios ?? this.servicios,
      filteredServicios: filteredServicios ?? this.filteredServicios,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Servicio> get displayList =>
      searchQuery.isEmpty ? servicios : filteredServicios;

  @override
  List<Object?> get props => [servicios, filteredServicios, searchQuery];
}

class ServicioSuccess extends ServicioState {
  final String message;
  const ServicioSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class ServicioError extends ServicioState {
  final String message;
  const ServicioError(this.message);
  @override
  List<Object?> get props => [message];
}