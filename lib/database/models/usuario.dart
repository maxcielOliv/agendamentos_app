import 'dart:io';
import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Usuario extends Entity {
  String? nome;
  String? senha;
  String? email;
  String? lotacao;
  String? nivel;

  bool admin = false;
  bool agendador = false;

  Usuario(
      {super.criacao,
      super.id,
      this.nome,
      this.senha,
      this.email,
      this.lotacao,
      this.nivel});

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'nome': nome,
      'senha': senha,
      'email': email,
      'lotacao': lotacao,
      'nivel': nivel
    };
  }

  Usuario.fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    id = document.id;
    nome = data?['nome'];
    email = data?['email'];
    senha = data?['senha'];
    lotacao = data?['lotacao'];
    nivel = data?['nivel'];
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
        lotacao: data?['lotacao'],
        nivel: data?['nivel']);
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
      'nivel': nivel
    };
  }

  Future<void> saveToken(String id) async {
    final token = await FirebaseMessaging.instance.getToken();
    final dbReference = FirebaseFirestore.instance.doc('usuario/$id');
    final tokenReference = dbReference.collection('tokens');
    tokenReference.doc(token).set({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }

  /*Future<void> saveNivelAdmin(String id, String nome) async {
    final dbReference = FirebaseFirestore.instance.doc('niveis/admin');
    final tokenReference = dbReference.collection('admin');
    tokenReference.doc(id).set({
      'nome': nome,
      'userId': id,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }*/

  /*Future<void> saveNivelAgend(String id, String nome) async {
    final dbReference = FirebaseFirestore.instance.doc('niveis/outros');
    final tokenReference = dbReference.collection('agendador');
    tokenReference.doc(id).set({
      'nome': nome,
      'userId': id,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }*/

  Future<void> saveNivel(String id, String nome, String nivel) async {
    if (nivel == 'Administrador') {
      final dbReference = FirebaseFirestore.instance.doc('niveis/admin');
      final nivelReference = dbReference.collection('admin');
      nivelReference.doc(id).set({
        'nome': nome,
        'userId': id,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    if (nivel == 'Agendador') {
      final dbReference = FirebaseFirestore.instance.doc('niveis/outros');
      final nivelReference = dbReference.collection('agendador');
      nivelReference.doc(id).set({
        'nome': nome,
        'userId': id,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
