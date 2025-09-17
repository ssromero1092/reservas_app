import 'package:reservas_app/features/domain/entities/recinto.dart';

class RecintoModel extends Recinto {
  const RecintoModel({
    required super.id,
    required super.descripcion,
  });

  factory RecintoModel.fromJson(Map<String, dynamic> json) =>  RecintoModel(
      id: json['id_recinto'],
      descripcion: json['descripcion'],
  );
}