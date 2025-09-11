import 'package:reservas_app/features/domain/entities/cliente.dart';

class ClienteModel extends Cliente {
  ClienteModel({
    required super.idCliente,
    required super.nombreCompleto,
    required super.rut,
    required super.telefono,
    required super.email,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      idCliente: json['id_cliente'],
      nombreCompleto: json['nombre_completo'],
      rut: json['rut'],
      telefono: json['telefono'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'nombre_completo': nombreCompleto,
      'rut': rut,
      'telefono': telefono,
      'email': email,
    };
  }
}
