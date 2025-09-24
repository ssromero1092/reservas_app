import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';

class TipoHospedajeModel extends TipoHospedaje {
  TipoHospedajeModel({
    required super.idTipoHospedaje,
    required super.descripcion,
    required super.equipamiento,
  });

  factory TipoHospedajeModel.fromJson(Map<String, dynamic> json) {
    return TipoHospedajeModel(
      idTipoHospedaje: json['id_tipo_hospedaje'],
      descripcion: json['descripcion'],
      equipamiento: json['equipamiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tipo_hospedaje': idTipoHospedaje,
      'descripcion': descripcion,
      'equipamiento': equipamiento,
    };
  }
}