abstract class Entity {
  String? id;
  final DateTime? criacao;

  Entity({this.id, this.criacao});

  Map<String, dynamic> toFirestore();
}
