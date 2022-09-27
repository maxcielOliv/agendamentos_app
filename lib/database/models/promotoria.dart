import 'package:agendamentos_app/database/models/entity.dart';

class Promotoria extends Entity{

  final String nome;

  Promotoria({
    required this.nome
  });
  
  @override
  Map<String, dynamic> toMap() {
    return criacao..addAll({'nome': nome});
  }

}