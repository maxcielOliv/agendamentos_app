import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Veiculo extends Entity {
  final String placa;
  final String modelo;
  final String? motorista;
  Veiculo(
      {super.id,
      super.criacao,
      required this.placa,
      required this.modelo,
      this.motorista});

  factory Veiculo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Veiculo(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        placa: data?['placa'],
        modelo: data?['modelo'],
        motorista: data?['motorista']);
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {'placa': placa, 'modelo': modelo};
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Modelo: $modelo | Placa: $placa | Motorista $motorista';
  }
}
