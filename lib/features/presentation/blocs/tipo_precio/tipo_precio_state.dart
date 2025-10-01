part of 'tipo_precio_bloc.dart';

abstract class TipoPrecioState extends Equatable {
  const TipoPrecioState();

  @override
  List<Object?> get props => [];
}

class TipoPrecioInitial extends TipoPrecioState {}

class TipoPrecioLoading extends TipoPrecioState {}

class TipoPrecioLoaded extends TipoPrecioState {
  final List<TipoPrecio> tipoPrecios;
  final List<TipoPrecio> filteredTipoPrecios;
  final String searchQuery;

  const TipoPrecioLoaded(
    this.tipoPrecios, {
    this.filteredTipoPrecios = const [],
    this.searchQuery = '',
  });

  TipoPrecioLoaded copyWith({
    List<TipoPrecio>? tipoPrecios,
    List<TipoPrecio>? filteredTipoPrecios,
    String? searchQuery,
  }) {
    return TipoPrecioLoaded(
      tipoPrecios ?? this.tipoPrecios,
      filteredTipoPrecios: filteredTipoPrecios ?? this.filteredTipoPrecios,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<TipoPrecio> get displayList =>
      searchQuery.isEmpty ? tipoPrecios : filteredTipoPrecios;

  @override
  List<Object?> get props => [tipoPrecios, filteredTipoPrecios, searchQuery];
}

class TipoPrecioSuccess extends TipoPrecioState {
  final String message;

  const TipoPrecioSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TipoPrecioError extends TipoPrecioState {
  final String message;

  const TipoPrecioError(this.message);

  @override
  List<Object?> get props => [message];
}
