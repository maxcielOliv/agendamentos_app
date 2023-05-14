import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario extends Entity {
  final String nome;
  final String senha;
  final String email;

  bool admin = false;

  Usuario(
      {super.id,
      super.criacao,
      required this.nome,
      required this.senha,
      required this.email});

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'senha': senha, 'email': email};
  }

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Usuario(
      id: snapshot.id,
      criacao: data?['criacao']?.toDate(),
      nome: data?['nome'],
      senha: data?['senha'],
      email: data?['email'],
    );
  }
  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | Senha: $senha | E-mail $email';
  }
}
