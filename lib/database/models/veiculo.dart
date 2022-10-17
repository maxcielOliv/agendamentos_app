import 'package:agendamentos_app/database/models/entity.dart';

class Veiculo extends Entity{

  final String placa;
  final String modelo;

  Veiculo({
    required this.placa,
    required this.modelo
  });
  
  @override
  Map<String, dynamic> toMap() {
   return criacao..addAll({'placa': placa, 'modelo': modelo});
  }
  
}