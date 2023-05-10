import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Agendamento extends Entity {
  final DateTime data;
  final String local;
  final String motorista;
  final String veiculo;
  final DateTime horaInicio;
  final DateTime? horaTermino;
  final String? policiamento;
  final String? promotoria;
  final String? promotor;

  Agendamento(
      {super.id,
      super.criacao,
      required this.data,
      required this.local,
      required this.motorista,
      required this.veiculo,
      required this.horaInicio,
      this.horaTermino,
      this.policiamento,
      this.promotoria,
      this.promotor});

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'data': data,
      'local': local,
      'motorista': motorista,
      'veiculo': veiculo,
      'horaInicio': horaInicio,
      'horaTermino': horaTermino,
      'policiamento': policiamento,
      'promotoria': promotoria,
      'promotor': promotor
    };
  }

  factory Agendamento.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    //SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Agendamento(
        id: snapshot.id,
        criacao: data?['criacao']?.toDate(),
        data: data?['data'],
        local: data?['local'],
        motorista: data?['motorista'],
        veiculo: data?['veiculo'],
        horaInicio: data?['horaInicio'],
        horaTermino: data?['horaTermino'],
        policiamento: data?['policiamento'],
        promotoria: data?['promotoria'],
        promotor: data?['promotor']);
  }
  @override
  String toString() {
    return 'Id: ${id ?? '?'} | Data: $data | Local: $local | Motorista: $motorista | Veiculo: $veiculo';
  }
}
