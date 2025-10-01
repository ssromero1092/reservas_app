part of 'lista_precio_bloc.dart';

abstract class ListaPrecioEvent extends Equatable {
  const ListaPrecioEvent();

  @override
  List<Object?> get props => [];
}

/// Cargar todas las listas de precio
class LoadListaPrecios extends ListaPrecioEvent {
  const LoadListaPrecios();
}

/// Crear una nueva lista de precio
class AddListaPrecio extends ListaPrecioEvent {
  final ListaPrecio listaPrecio;

  const AddListaPrecio(this.listaPrecio);

  @override
  List<Object?> get props => [listaPrecio];
}

/// Actualizar una lista de precio existente
class UpdateListaPrecio extends ListaPrecioEvent {
  final ListaPrecio listaPrecio;

  const UpdateListaPrecio(this.listaPrecio);

  @override
  List<Object?> get props => [listaPrecio];
}

/// Eliminar una lista de precio por ID
class DeleteListaPrecio extends ListaPrecioEvent {
  final int id;

  const DeleteListaPrecio(this.id);

  @override
  List<Object?> get props => [id];
}

/// Buscar en la lista de precios
class SearchListaPrecios extends ListaPrecioEvent {
  final String query;

  const SearchListaPrecios(this.query);

  @override
  List<Object?> get props => [query];
}