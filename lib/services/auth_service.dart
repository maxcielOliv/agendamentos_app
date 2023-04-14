import 'package:agendamentos_app/screens/home_page.dart';
import 'package:agendamentos_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool carregando = true;

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  login(String email, String senha, context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: senha)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
      _getUser();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        throw AuthException('Informe E-mail e senha');
      } else if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  sigUp(String email, String senha, context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException('Informe E-mail e senha');
      } else if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está cadastrado');
      }
    }
  }

  logout(context) async {
    await _auth.signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    });
    _getUser();
  }
}
