import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../usuario.dart';
import 'dao.dart';

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
  Future<List<Usuario>> getAll() async {
    final res = await db.collection('usuario').get();
    return res.docs.map((e) => Usuario.fromFirestore(e)).toList();
  }

  @override
  // ignore: override_on_non_overriding_member
  Stream<List<Usuario>> getAllStream() async* {
    yield* db
        .collection('usuario')
        .snapshots()
        .map((e) => e.docs.map((e) => Usuario.fromFirestore(e)).toList());
  }
}
