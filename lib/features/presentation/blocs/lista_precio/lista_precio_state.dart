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
  final List<ListaPrecio> filteredListaPrecios;
  final String searchQuery;

  const ListaPrecioLoaded(
    this.listaPrecios, {
    this.filteredListaPrecios = const [],
    this.searchQuery = '',
  });

  ListaPrecioLoaded copyWith({
    List<ListaPrecio>? listaPrecios,
    List<ListaPrecio>? filteredListaPrecios,
    String? searchQuery,
  }) {
    return ListaPrecioLoaded(
      listaPrecios ?? this.listaPrecios,
      filteredListaPrecios: filteredListaPrecios ?? this.filteredListaPrecios,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<ListaPrecio> get displayList =>
  searchQuery.isEmpty ? listaPrecios : filteredListaPrecios;

  @override
  List<Object?> get props => [listaPrecios, filteredListaPrecios, searchQuery];
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