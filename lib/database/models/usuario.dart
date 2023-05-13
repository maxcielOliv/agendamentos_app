import 'dart:io';
import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  get firestoreRef => FirebaseFirestore.instance.collection('usuario').doc(id);

  CollectionReference get tokensReference => firestoreRef.collection('token');

  Future<void> saveToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    final db = FirebaseFirestore.instance;
    // final dao = UsuarioDao();
    await tokensReference.doc(token).set(
      {
        'token': token,
        'updatedAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
      },
    );
  }
}
