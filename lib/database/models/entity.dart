abstract class Entity {
  final String? id;
  final DateTime? criacao;

  Entity({this.id, this.criacao});

  Map<String, dynamic> toFirestore();
}
