import 'package:reservas_app/features/domain/entities/servicio.dart';

class ServicioModel extends Servicio {
  const ServicioModel({
    required super.idServicio,
    required super.descripcion,
    required super.valorReferencial,
    required super.observacion,
  });

  factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        idServicio: json['id_servicio'],
        descripcion: json['descripcion'],
        valorReferencial: json['valor_referencial'],
        observacion: json['observacion'],
      );

  Map<String, dynamic> toJson() => {
        'id_servicio': idServicio,
        'descripcion': descripcion,
        'valor_referencial': valorReferencial,
        'observacion': observacion,
      };
}