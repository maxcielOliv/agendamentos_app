import 'package:agendamentos_app/database/models/entity.dart';

class Promotor extends Entity{

  final String nome;
  final int cpf;
  final int matricula;

  Promotor({
    required this.nome,
    required this.cpf,
    required this.matricula
  });
  
  @override
  Map<String, dynamic> toMap() {
    return criacao..addAll({'nome': nome, 'cpf': cpf, 'matricula': matricula});
  }
}