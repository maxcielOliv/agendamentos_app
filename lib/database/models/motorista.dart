// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Motorista extends Entity {
  final String nome;
  final int? cpf;
  final int? matricula;

  Motorista({
    super.id,
    super.criacao,
    super.atualizacao,
    required this.nome,
    this.cpf,
    this.matricula,
  });

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
        atualizacao: data?['atualizacao']?.toDate(),
        nome: data?['nome'],
        cpf: data?['cpf'],
        matricula: data?['matricula']);
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Nome: $nome | CPF: $cpf | Matricula: $matricula';
  }

  Motorista copyWith({
    String? nome,
    int? cpf,
    int? matricula,
  }) {
    return Motorista(
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      matricula: matricula ?? this.matricula,
    );
  }

  @override
  bool operator ==(covariant Motorista other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.cpf == cpf &&
        other.matricula == matricula;
  }

  @override
  int get hashCode => nome.hashCode ^ cpf.hashCode ^ matricula.hashCode;
}
