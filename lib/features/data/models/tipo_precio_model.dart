import 'package:reservas_app/features/domain/entities/tipo_precio.dart';

class TipoPrecioModel extends TipoPrecio {
  TipoPrecioModel({
    required super.idTipoPrecio,
    required super.descripcion,
    required super.observacion,
  });

  factory TipoPrecioModel.fromJson(Map<String, dynamic> json) {
    return TipoPrecioModel(
      idTipoPrecio: json['id_tipo_precio'],
      descripcion: json['descripcion'],
      observacion: json['observacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tipo_precio': idTipoPrecio,
      'descripcion': descripcion,
      'observacion': observacion,
    };
  }
}
