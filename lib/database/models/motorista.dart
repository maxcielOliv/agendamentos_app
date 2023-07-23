// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Motorista extends Entity {
  final String nome;
  final String? fone;

  Motorista({
    super.id,
    super.criacao,
    super.atualizacao,
    required this.nome,
    this.fone,
  });

  @override
  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'celular': fone};
  }

  factory Motorista.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Motorista(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        atualizacao: data?['atualizacao']?.toDate(),
        nome: data?['nome'],
        fone: data?['celular']);
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | Celular: $fone';
  }

  Motorista copyWith(String nome) {
    return Motorista(
      nome: nome,
      fone: fone,
    );
  }

  @override
  bool operator ==(covariant Motorista other) {
    if (identical(this, other)) return true;

    return other.nome == nome && other.fone == fone;
  }

  @override
  int get hashCode => nome.hashCode ^ fone.hashCode;
}
