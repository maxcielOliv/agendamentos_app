import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Dao<T extends Entity> {

  final _db = FirebaseFirestore.instance;

  T? get(String id , {T? entity}) {
    _db.collection(entity.runtimeType
    .toString()
    .toLowerCase())
    .where(id, isEqualTo: true)
    .get()
    .then(
      (res) => print("Successfully completed"),
      onError: (e) => print("Error completing: $e"),
    );
  }

  List<T> getAll();

  //inserir dados
  void save(T entity) {
    _db
        .collection(entity.runtimeType.toString().toLowerCase())
        .doc()
        .set(entity.toMap())
        .onError((e, _) => print("Error writing document: $e"));
  }

  void update(T entity);

  //
  T? delete(T entity) {
      _db
        .collection(entity.runtimeType.toString().toLowerCase())
        .doc()
        .delete()
        .then((doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
    );

  }
  
}