import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Promotor extends Entity {
  String? nome;
  String? matricula;
  String? lotacao;

  Promotor(
      {super.id, super.criacao, this.nome, this.matricula, this.lotacao});

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'matricula': matricula, 'lotacao': lotacao};
  }

  factory Promotor.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Promotor(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        nome: data?['nome'],
        matricula: data?['matricula'],
        lotacao: data?['lotacao']);
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | Matricula: $matricula | Lotação: $lotacao';
  }
}
