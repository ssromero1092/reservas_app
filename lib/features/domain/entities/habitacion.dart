import 'package:reservas_app/features/domain/entities/recinto.dart';

class Habitacion {
  final int idHabitacion;
  final String descripcion;
  final String capacidad;
  final int idRecinto;
  final Recinto? recinto;

  Habitacion({
    required this.idHabitacion,
    required this.descripcion,
    required this.capacidad,
    required this.idRecinto,
    required this.recinto,
  });
}

