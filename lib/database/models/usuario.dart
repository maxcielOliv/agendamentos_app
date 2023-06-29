import 'dart:io';
import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Usuario extends Entity {
  String? nome;
  String? senha;
  String? email;
  String? lotacao;

  Usuario(
      {super.criacao,
      super.id,
      this.nome,
      this.senha,
      this.email,
      this.lotacao});

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'senha': senha, 'email': email, 'lotacao': lotacao};
  }

  Usuario.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    id = document.id;
    nome = data?['nome'];
    email = data?['email'];
    senha = data?['senha'];
    lotacao = data?['lotacao'];
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
        lotacao: data?['lotacao']);
  }
  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | Senha: $senha |E-mail $email';
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('usuario/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'criacao': FieldValue.serverTimestamp(),
      'nome': nome,
      'email': email,
      'lotacao': lotacao,
    };
  }

  Future<void> saveToken(String id) async {
    final token = await FirebaseMessaging.instance.getToken();
    final dbReference = FirebaseFirestore.instance.doc('usuario/$id');
    final tokenReference = dbReference.collection('tokens');
    tokenReference.doc(token).set(
      {
        'token': token,
        'updatedAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
      },
    );
  }
}
