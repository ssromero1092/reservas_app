import 'package:reservas_app/features/data/models/tipo_hospedaje_model.dart';
import 'package:reservas_app/features/data/models/tipo_precio_model.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';

class ListaPrecioModel extends ListaPrecio {
  ListaPrecioModel({
    required super.idListaPrecio,
    required super.valor,
    required super.idTipoHospedaje,
    required super.idTipoPrecio,
    super.tipoHospedaje,
    super.tipoPrecio,
  });

  factory ListaPrecioModel.fromJson(Map<String, dynamic> json) {
    return ListaPrecioModel(
      idListaPrecio: json['id_lista_precio'],
      valor: json['valor'],
      idTipoHospedaje: json['id_tipo_hospedaje'],
      idTipoPrecio: json['id_tipo_precio'],
      tipoHospedaje: json['TipoHospedaje'] != null 
          ? TipoHospedajeModel.fromJson(json['TipoHospedaje']) 
          : null,
      tipoPrecio: json['TipoPrecio'] != null 
          ? TipoPrecioModel.fromJson(json['TipoPrecio']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_lista_precio': idListaPrecio,
      'valor': valor,
      'id_tipo_hospedaje': idTipoHospedaje,
      'id_tipo_precio': idTipoPrecio,
      if (tipoHospedaje != null)
        'TipoHospedaje': (tipoHospedaje as TipoHospedajeModel).toJson(),
      if (tipoPrecio != null)
        'TipoPrecio': (tipoPrecio as TipoPrecioModel).toJson(),
    };
  }
}
