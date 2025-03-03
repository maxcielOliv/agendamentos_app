//Class Entity - Entidade
//Criada para recuperar o ID das tabelas, data de criação e atualização dos dados
abstract class Entity {
  String? id;
  final DateTime? criacao;
  final DateTime? atualizacao;

  Entity({this.id, this.criacao, this.atualizacao});

  Map<String, dynamic> toFirestore();
}
