import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario extends Entity {
  final String usuario;
  final String senha;

  Usuario({
    super.id,
    super.criacao,
    required this.usuario,
    required this.senha,
  });

  @override
  Map<String, dynamic> toFirestore() {
    return {'usuario': usuario, 'senha': senha};
  }

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Usuario(
      id: snapshot.id,
      criacao: data?['criacao']?.toDate(),
      usuario: data?['usuario'],
      senha: data?['senha'],
    );
  }
}
