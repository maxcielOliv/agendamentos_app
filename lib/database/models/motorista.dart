import 'package:agendamentos_app/database/models/entity.dart';

class Motorista extends Entity {

  final String nome;
  final int cpf;
  final int? matricula;

  Motorista({
    required this.nome,
    required this.cpf,
    this.matricula
  });
  
  @override
  Map<String, dynamic> toMap() {
    return criacao..addAll({'nome': nome, 'cpf': cpf, 'matricula': matricula});
  }
  

}