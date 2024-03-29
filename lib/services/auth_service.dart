import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Classe de autenticação
//Reponsável por fazer a verificação das informações de login do usuário ao logar no sistema
//Antes de chegar a tela inicial do programa, todas as informações passarão por essa classe
class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._();
  AuthService._();
  factory AuthService() => _instance;

  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Usuario? user;

  //User? get user => _auth.currentUser;

  Future<bool> login(String email, String senha) async {
    try {
      final UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await _loadCurrentUser(firebaseuser: result.user);

      result.user!.uid;

      user?.saveToken(result.user!.uid);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido');
      } else if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta');
      }
      throw AuthException('Erro desconhecido');
    }
  }

  Future<void> signUp({required Usuario user}) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.senha!);
      user.id = result.user?.uid;
      await user.saveData();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException('Informe E-mail e senha');
      }
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está cadastrado');
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> _loadCurrentUser({User? firebaseuser}) async {
    final User? currentUser = firebaseuser ?? _auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> docUser =
          await _db.collection('usuario').doc(currentUser.uid).get();
      user = Usuario.fromDocument(docUser);
      //print(user?.nome);

      final docAdmin = await _db
          .collection('niveis')
          .doc('admin')
          .collection('admin')
          .doc(user?.id)
          .get();
      if (docAdmin.exists) {
        user?.admin = true;
        //print('administrador: ${user?.admin}');
      }

      final docAgander = await _db
          .collection('niveis')
          .doc('outros')
          .collection('agendador')
          .doc(user?.id)
          .get();
      if (docAgander.exists) {
        user?.agendador = true;
        print('agendador: ${user?.agendador}');
      }

      notifyListeners();
    }
  }

  bool get adminEnabled => user!.admin;
  bool get agendEnabled => user!.agendador;
}
