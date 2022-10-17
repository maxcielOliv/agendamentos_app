import 'dart:async';

import 'package:agendamentos_app/database/models/dao/dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioDao extends Dao<Usuario> {
  final _db = FirebaseFirestore.instance;
  @override
  List<Usuario> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  void update(Usuario entity) {
    // TODO: implement update
  }
  
  @override
  Usuario? get(Usuario entity) {
    final docRef = _db
        .collection(entity.runtimeType.toString().toLowerCase())
        .doc("NkdM6Ew0nzU9YuabUpTm");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
      }
    );
  }
  
  @override
  void delete(Usuario entity) {
     _db
        .collection(entity.runtimeType.toString().toLowerCase())
        .doc('LihQhOyN6ZHv4M3D7NQx')
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

}
