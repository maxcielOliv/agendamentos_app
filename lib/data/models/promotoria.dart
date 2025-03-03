import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Promotoria extends Entity {
  final String nome;

  Promotoria({super.id, super.criacao, required this.nome});

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome};
  }

  factory Promotoria.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Promotoria(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        nome: data?['nome']);
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome ';
  }

  Promotoria copywith() {
    return Promotoria(id: id, criacao: criacao, nome: nome);
  }
}
