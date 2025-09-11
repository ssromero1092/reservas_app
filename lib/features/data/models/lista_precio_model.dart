import 'package:reservas_app/features/domain/entities/lista_precio.dart';

class ListaPrecioModel extends ListaPrecio {
  ListaPrecioModel({
    required super.idListaPrecio,
    required super.valor,
    required super.idTipoHospedaje,
    required super.idTipoPrecio,
  });

  factory ListaPrecioModel.fromJson(Map<String, dynamic> json) {
    return ListaPrecioModel(
      idListaPrecio: json['id_lista_precio'],
      valor: json['valor'],
      idTipoHospedaje: json['id_tipo_hospedaje'],
      idTipoPrecio: json['id_tipo_precio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_lista_precio': idListaPrecio,
      'valor': valor,
      'id_tipo_hospedaje': idTipoHospedaje,
      'id_tipo_precio': idTipoPrecio,
    };
  }
}
