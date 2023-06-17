import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String mensagem;
  AuthException(this.mensagem);
}

class UserManager extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  late Usuario user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn(
      {required Usuario user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email!, password: user.senha!);

      await _loadCurrentUser(firebaseuser: result.user);

      result.user!.uid;

      user.saveToken(result.user!.uid);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        throw AuthException('Informe E-mail e senha');
      } else if (e.code == 'auth/user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se.');
      } else if (e.code == 'auth/wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
      onFail(e.message);
    }
    loading = false;
  }

  Future<void> signUp(
      {required Usuario user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.senha!);
      user.id = result.user?.uid;
      await user.saveData();

      onSuccess();
    } on FirebaseAuthException catch (e) {
      e.message;
    }
    loading = false;
  }

  Future<void> signOut(context) async {
    await auth.signOut().then(
      (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseuser}) async {
    final User? currentUser = firebaseuser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot<Map<String, dynamic>> docUser =
          await db.collection('usuario').doc(currentUser.uid).get();
      user = Usuario.fromDocument(docUser);
      final docAdmin = await db.collection('admins').doc(user.id).get();
      if (docAdmin.exists) {
        user.admin = true;
      }
      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.admin;
}
