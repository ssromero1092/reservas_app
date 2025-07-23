import 'package:reservas_app/features/data/models/empresa_model.dart';

class LoginResponseModel {
  final String token;
  final bool estado;
  final EmpresaModel empresa;
  final String dbname; 

  LoginResponseModel({
    required this.token,
    required this.estado,
    required this.empresa,
    required this.dbname, 
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['data']['token'] as String,
      estado: json['data']['estado'] as bool,
      empresa: EmpresaModel.fromJson(json['data']['empresa'] as Map<String, dynamic>),
      dbname: 'reservas_0015',//quemado en codigo
    );
  }
}