part of 'reservas_bloc.dart';

abstract class ReservasEvent extends Equatable {
  const ReservasEvent();
  @override
  List<Object> get props => [];
}

class reservas extends ReservasEvent {
  const reservas();
}

