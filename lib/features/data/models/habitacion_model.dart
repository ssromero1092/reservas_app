import 'package:reservas_app/features/domain/entities/habiltacion.dart';

class HabitacionModel extends Habitacion {
  HabitacionModel({
    required super.idHabitacion,
    required super.descripcion,
    required super.capacidad,
    required super.idRecinto,
  });

  factory HabitacionModel.fromJson(Map<String, dynamic> json) {
    return HabitacionModel(
      idHabitacion: json['id_habitacion'],
      descripcion: json['descripcion'],
      capacidad: json['capacidad'],
      idRecinto: json['id_recinto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_habitacion': idHabitacion,
      'descripcion': descripcion,
      'capacidad': capacidad,
      'id_recinto': idRecinto,
    };
  }
}
