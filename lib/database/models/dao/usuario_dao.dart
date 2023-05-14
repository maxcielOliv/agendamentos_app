import 'dart:developer';
import 'package:agendamentos_app/database/models/dao/dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UsuarioDao extends Dao<Usuario> {
  @override
  Future<Usuario?> get(String id) async {
    final res = await db.collection('usuario').doc(id).get();
    return res.exists ? Usuario.fromFirestore(res) : null;
  }

  // Future<Usuario?> getNome(String nome) async {
  //   final res = await db.collection('usuario').where('usuario').get();
  //   if (res.size > 0) {
  //     return Usuario.fromFirestore(res.docs.first);
  //   }
  // }

  @override
  Future<bool> salvar(Usuario entity) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      await db.collection('usuario').add(
            {
              'criacao': FieldValue.serverTimestamp(),
              'token': token,
            }..addAll(
                entity.toFirestore(),
              ),
          );
      return true;
    } on FirebaseException catch (error) {
      log(
        'Erro ao salvar',
        error: error,
        name: 'ATENÇÃO',
      );
      return false;
    }
  }

  @override
  Future<List<Usuario>> getAll() async {
    final res = await db.collection('usuario').get();
    return res.docs.map((e) => Usuario.fromFirestore(e)).toList();
  }

  Stream<List<Usuario>> getAllStream() async* {
    yield* db
        .collection('usuario')
        .snapshots()
        .map((e) => e.docs.map((e) => Usuario.fromFirestore(e)).toList());
  }
}
