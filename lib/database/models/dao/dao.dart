import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entity.dart';

//Classe Abstrata que será herdada pelas outras classes
//Nessa classe foram criados os metodos de pegar, salvar e deletar
abstract class Dao<T extends Entity> {
  final db = FirebaseFirestore.instance;

  Future<T?> get(String id);

  Future<List<T>> getAll();

  Future<bool> salvar(T entity) async {
    try {
      await db
          .collection(entity.runtimeType.toString().toLowerCase())
          .doc(entity.id)
          .set(
              entity.id != null
                  ? {'atualizacao': FieldValue.serverTimestamp()}
                  : {'criacao': FieldValue.serverTimestamp()}
                ..addAll(entity.toFirestore()),
              SetOptions(merge: entity.id != null));
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

  Future<bool> deletar(T entity) async {
    if (entity.id != null) {
      try {
        await db
            .collection(entity.runtimeType.toString().toLowerCase())
            .doc(entity.id)
            .delete();
        return true;
      } catch (error) {
        log(
          'Erro ao deletar',
          error: error,
          name: 'ATENÇÃO',
        );
        return false;
      }
    }
    return false;
  }
}
