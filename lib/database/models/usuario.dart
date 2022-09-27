import 'package:agendamentos_app/database/models/entity.dart';

class Usuario extends Entity  {

final String usuario;
final String senha;

Usuario({
  required this.usuario,
  required this.senha
});

  @override
  Map<String, dynamic> toMap() {
    return criacao..addAll({'usuario': usuario, 'senha': senha});
  }
}


