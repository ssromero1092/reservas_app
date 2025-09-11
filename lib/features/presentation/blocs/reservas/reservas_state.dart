part of 'reservas_bloc.dart';

sealed class ReservasState extends Equatable {
  const ReservasState();
  
  @override
  List<Object> get props => [];
}

final class ReservasInitial extends ReservasState {}
final class ReservasLoading extends ReservasState {}
final class ReservasLoaded extends ReservasState {
  final List<Reserva> reservas;

  const ReservasLoaded(this.reservas);

  @override
  List<Object> get props => [reservas];
}

final class ReservasError extends ReservasState {
  final String message;

  const ReservasError(this.message);

  @override
  List<Object> get props => [message];
}