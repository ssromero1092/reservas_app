import 'package:reservas_app/features/data/models/recinto_model.dart';
import 'package:reservas_app/features/domain/entities/habitacion.dart';

class HabitacionModel extends Habitacion {
  HabitacionModel({
    required super.idHabitacion,
    required super.descripcion,
    required super.capacidad,
    required super.idRecinto,
    required super.recinto,
  });

  factory HabitacionModel.fromJson(Map<String, dynamic> json) {
    return HabitacionModel(
      idHabitacion: json['id_habitacion'],
      descripcion: json['descripcion'],
      capacidad: json['capacidad'],
      idRecinto: json['id_recinto'],
      recinto: json['Recinto'] != null ? RecintoModel.fromJson(json['Recinto']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_habitacion': idHabitacion,
      'descripcion': descripcion,
      'capacidad': capacidad,
      'id_recinto': idRecinto,
      'Recinto': (recinto as RecintoModel).toJson(),
    };
  }
}
