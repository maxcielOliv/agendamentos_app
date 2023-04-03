import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Promotor extends Entity {
  final String nome;
  final int matricula;

  Promotor(
      {super.id, super.criacao, required this.nome, required this.matricula});

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'matricula': matricula};
  }

  factory Promotor.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Promotor(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        nome: data?['nome'],
        matricula: data?['matricula']);
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | Matricula: $matricula';
  }
}
