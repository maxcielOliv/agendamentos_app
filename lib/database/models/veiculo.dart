import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Veiculo extends Entity {
  final String marca;
  final String placa;
  final String modelo;
  final String? motorista;
  
  Veiculo(
      {super.id,
      super.criacao,
      required this.marca,
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
        marca: data?['marca'],
        placa: data?['placa'],
        modelo: data?['modelo'],
        motorista: data?['motorista']);
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {'marca': marca, 'placa': placa, 'modelo': modelo, 'motorista': motorista};
  }

  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Marca: $marca | Modelo: $modelo | Placa: $placa | Motorista $motorista';
  }
}
