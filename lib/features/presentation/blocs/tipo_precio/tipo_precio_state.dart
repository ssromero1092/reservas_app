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

  const TipoPrecioLoaded(this.tipoPrecios);

  @override
  List<Object?> get props => [tipoPrecios];
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
