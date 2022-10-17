import 'package:agendamentos_app/database/models/entity.dart';

class Unidade extends Entity{

  final String nome;

  Unidade({
    required this.nome
  });
  
  @override
  Map<String, dynamic> toMap() {
    return criacao..addAll({'nome': nome});
  }

}