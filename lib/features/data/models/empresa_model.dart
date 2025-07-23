class EmpresaModel {
  final int idEmpresa;
  final String nombreFantasia;
  final int numeroUnico;
  final int idAreaNegocio;

  EmpresaModel({
    required this.idEmpresa,
    required this.nombreFantasia,
    required this.numeroUnico,
    required this.idAreaNegocio,
  });

  factory EmpresaModel.fromJson(Map<String, dynamic> json) {
    return EmpresaModel(
      idEmpresa: json['id_empresa'] as int,
      nombreFantasia: json['nombre_fantasia'] as String,
      numeroUnico: json['numero_unico'] as int,
      idAreaNegocio: json['id_area_negocio'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_empresa': idEmpresa,
      'nombre_fantasia': nombreFantasia,
      'numero_unico': numeroUnico,
      'id_area_negocio': idAreaNegocio,
    };
  }
  
}
