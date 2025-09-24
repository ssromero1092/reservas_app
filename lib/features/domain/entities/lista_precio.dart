import 'package:reservas_app/features/domain/entities/tipo_hospedaje.dart';
import 'package:reservas_app/features/domain/entities/tipo_precio.dart';

class ListaPrecio {
  final int idListaPrecio;
  final int valor;
  final int idTipoHospedaje;
  final int idTipoPrecio;
  final TipoHospedaje? tipoHospedaje;
  final TipoPrecio? tipoPrecio;

  ListaPrecio({
    required this.idListaPrecio,
    required this.valor,
    required this.idTipoHospedaje,
    required this.idTipoPrecio,
    this.tipoHospedaje,
    this.tipoPrecio,
  });
}
