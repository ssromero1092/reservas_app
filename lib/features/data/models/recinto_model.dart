import 'package:reservas_app/features/domain/entities/recinto.dart';

class RecintoModel extends Recinto {
  const RecintoModel({required super.idRecinto, required super.descripcion});

  factory RecintoModel.fromJson(Map<String, dynamic> json) => RecintoModel(
    idRecinto: json['id_recinto'],
    descripcion: json['descripcion'],
  );
  Map<String, dynamic> toJson() => {
    'id_recinto': idRecinto,
    'descripcion': descripcion,
  };
}
