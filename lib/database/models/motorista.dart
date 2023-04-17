import 'package:agendamentos_app/database/models/entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Motorista extends Entity {
  final String nome;
  final int? cpf;
  final int? matricula;

  Motorista(
      {super.id, super.criacao, required this.nome, this.cpf, this.matricula});

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'cpf': cpf, 'matricula': matricula};
  }

  factory Motorista.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Motorista(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        nome: data?['nome'],
        cpf: data?['cpf'],
        matricula: data?['matricula']);
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | CPF: $cpf | Matricula: $matricula';
  }
}
