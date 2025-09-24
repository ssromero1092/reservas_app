part of 'lista_precio_bloc.dart';

abstract class ListaPrecioState extends Equatable {
  const ListaPrecioState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class ListaPrecioInitial extends ListaPrecioState {}

/// Mostrando progreso
class ListaPrecioLoading extends ListaPrecioState {}

/// Lista cargada con éxito
class ListaPrecioLoaded extends ListaPrecioState {
  final List<ListaPrecio> listaPrecios;

  const ListaPrecioLoaded(this.listaPrecios);

  @override
  List<Object?> get props => [listaPrecios];
}

/// Operación exitosa sin datos adicionales (ej. delete, update)
class ListaPrecioSuccess extends ListaPrecioState {
  final String message;

  const ListaPrecioSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Error al ejecutar la acción
class ListaPrecioError extends ListaPrecioState {
  final String message;

  const ListaPrecioError(this.message);

  @override
  List<Object?> get props => [message];
}