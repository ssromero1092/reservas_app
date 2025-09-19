import 'package:reservas_app/features/domain/entities/cliente.dart';
import 'package:reservas_app/features/domain/entities/estado_reserva.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';

class Reserva {
  final String fechaDesde;
  final String fechaHasta;
  final int idReserva;
  final int noches;
  final int total;
  final int deposito;
  final int adultos;
  final int ninos;
  final String observacion;
  final int idHabitacion;
  final int idCliente;
  final int idListaPrecio;
  final int idEstadoReserva;
  final Habitacion habitacion;
  final Cliente cliente;
  final ListaPrecio listaPrecio;
  final EstadoReserva estadoReserva;

  Reserva({
    required this.fechaDesde,
    required this.fechaHasta,
    required this.idReserva,
    required this.noches,
    required this.total,
    required this.deposito,
    required this.adultos,
    required this.ninos,
    required this.observacion,
    required this.idHabitacion,
    required this.idCliente,
    required this.idListaPrecio,
    required this.idEstadoReserva,
    required this.habitacion,
    required this.cliente,
    required this.listaPrecio,
    required this.estadoReserva,
  });
}
