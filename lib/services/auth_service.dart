import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._();
  AuthService._();
  factory AuthService() => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<bool> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
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

  Future<void> sigUp(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
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
}
