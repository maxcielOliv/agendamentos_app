import 'dart:developer';

import 'package:agendamentos_app/database/models/dao/dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MotoristaDao extends Dao<Motorista> {
  @override
  Future<Motorista?> get(String id) async {
    final res = await db.collection('motorista').doc(id).get();
    return res.exists ? Motorista.fromFirestore(res) : null;
  }

  @override
  Future<List<Motorista>> getAll() async {
    final res = await db.collection('motorista').get();
    return res.docs.map((e) => Motorista.fromFirestore(e)).toList();
  }

  @override
  // ignore: override_on_non_overriding_member
  Stream<List<Motorista>> getAllStream() async* {
    yield* db
        .collection('motorista')
        .snapshots()
        .map((e) => e.docs.map((e) => Motorista.fromFirestore(e)).toList());
  }

  @override
  Future<bool> salvar(Motorista entity) async {
    try {
      await db
          .collection(entity.runtimeType.toString().toLowerCase())
          .doc(entity.id)
          .set(
            {'nome': '', 'criacao': FieldValue.serverTimestamp()}..addAll(
                entity.toFirestore(),
              ),
            SetOptions(merge: true),
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

  Future<bool> atualizar(Motorista entity) async {
    final _db = FirebaseFirestore.instance;
    //DocumentReference ref = await _db.collection('motorista').add({'nome': ''});
    final get = await _db.collection('motorista').get();
    print(get);
    //print(ref.id);
    //print(entity.id);
    try {
      await db
          .collection(entity.runtimeType.toString().toLowerCase())
          .doc() //passando id manual funciona 'VfYGfqg8pQ1sQUP0DMLq'
          .update(
            {entity.nome: ''}..addAll(
                entity.toFirestore(),
              ),
            //SetOptions(merge: true),
            //entity.id != null
          );
      return true;
    } on FirebaseException catch (error) {
      log(
        'Erro ao atualizar',
        error: error,
        name: 'ATENÇÃO',
      );
      return false;
    }
  }

  Future<bool> atualizar2(Motorista entity) async {
    try {
      await db.collection('motorista').add(
            {entity.nome: ''}
              ..update(entity.id.toString(), (value) => '')
              ..addAll(
                entity.toFirestore(),
              ),
            //SetOptions(merge: true),
            //entity.id != null
          );
      return true;
    } on FirebaseException catch (error) {
      log(
        'Erro ao atualizar',
        error: error,
        name: 'ATENÇÃO',
      );
      return false;
    }
  }
}
