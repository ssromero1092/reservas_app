part of 'tipo_precio_bloc.dart';

abstract class TipoPrecioEvent extends Equatable {
  const TipoPrecioEvent();

  @override
  List<Object?> get props => [];
}

class LoadTipoPrecios extends TipoPrecioEvent {
  const LoadTipoPrecios();
}

class AddTipoPrecio extends TipoPrecioEvent {
  final TipoPrecio tipoPrecio;

  const AddTipoPrecio(this.tipoPrecio);

  @override
  List<Object?> get props => [tipoPrecio];
}

class UpdateTipoPrecio extends TipoPrecioEvent {
  final TipoPrecio tipoPrecio;

  const UpdateTipoPrecio(this.tipoPrecio);

  @override
  List<Object?> get props => [tipoPrecio];
}

class DeleteTipoPrecio extends TipoPrecioEvent {
  final int id;

  const DeleteTipoPrecio(this.id);

  @override
  List<Object?> get props => [id];
}
