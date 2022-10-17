import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Dao<T extends Entity> {
  final _db = FirebaseFirestore.instance;
  
  void get(T entity);

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
  void delete(T entity);
}