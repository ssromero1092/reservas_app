import 'package:reservas_app/features/data/models/cliente_model.dart';
import 'package:reservas_app/features/data/models/estado_reserva_model.dart';
import 'package:reservas_app/features/data/models/habitacion_model.dart';
import 'package:reservas_app/features/data/models/lista_precio_model.dart';
import 'package:reservas_app/features/domain/entities/reserva.dart';

class ReservasModel extends Reserva{
  ReservasModel({required super.fechaDesde, required super.fechaHasta, required super.idReserva, required super.noches, required super.total, required super.deposito, required super.adultos, required super.ninos, required super.observacion, required super.idHabitacion, required super.idCliente, required super.idListaPrecio, required super.idEstadoReserva, required super.habitacion, required super.cliente, required super.listaPrecio, required super.estadoReserva});

factory ReservasModel.fromJson(Map<String, dynamic> json) {
    return ReservasModel(
      fechaDesde: json['fecha_desde'],
      fechaHasta: json['fecha_hasta'],
      idReserva: json['id_reserva'],
      noches: json['noches'],
      total: json['total'],
      deposito: json['deposito'],
      adultos: json['adultos'],
      ninos: json['ninos'],
      observacion: json['observacion'],
      idHabitacion: json['id_habitacion'],
      idCliente: json['id_cliente'],
      idListaPrecio: json['id_lista_precio'],
      idEstadoReserva: json['id_estado_reserva'],
      habitacion: HabitacionModel.fromJson(json['Habitacion']),
      cliente: ClienteModel.fromJson(json['Cliente']),
      listaPrecio: ListaPrecioModel.fromJson(json['ListaPrecio']),
      estadoReserva: EstadoReservaModel.fromJson(json['EstadoReserva']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'fecha_desde': fechaDesde,
      'fecha_hasta': fechaHasta,
      'id_reserva': idReserva,
      'noches': noches,
      'total': total,
      'deposito': deposito,
      'adultos': adultos,
      'ninos': ninos,
      'observacion': observacion,
      'id_habitacion': idHabitacion,
      'id_cliente': idCliente,
      'id_lista_precio': idListaPrecio,
      'id_estado_reserva': idEstadoReserva,
      'Habitacion': (habitacion as HabitacionModel).toJson(),
      'Cliente': (cliente as ClienteModel).toJson(),
      'ListaPrecio': (listaPrecio as ListaPrecioModel).toJson(),
      'EstadoReserva': (estadoReserva as EstadoReservaModel).toJson(),
    };
  }

  toEntity() {}
  
}