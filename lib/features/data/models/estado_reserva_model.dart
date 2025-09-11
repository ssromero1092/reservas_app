import 'package:reservas_app/features/domain/entities/estado_reserva.dart';

class EstadoReservaModel extends EstadoReserva {
  EstadoReservaModel({
    required super.idEstadoReserva,
    required super.descripcion,
    required super.color,
  });
  factory EstadoReservaModel.fromJson(Map<String, dynamic> json) {
    return EstadoReservaModel(
      idEstadoReserva: json['id_estado_reserva'],
      descripcion: json['descripcion'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estado_reserva': idEstadoReserva,
      'descripcion': descripcion,
      'color': color,
    };
  }
}
