import 'package:cloud_firestore/cloud_firestore.dart';
import 'entity.dart';

class Agendamento extends Entity {
  final DateTime? dataInicial;
  final DateTime? dataFinal;
  final String local; //
  late String? motorista; //
  late String? veiculo;
  final DateTime? horaInicio; //
  final DateTime? horaTermino; //
  final String? policiamento; //
  final String? promotoria; //
  final String? promotor;
  final String usuario;

  Agendamento(
      {super.id,
      super.criacao,
      this.dataInicial,
      this.dataFinal,
      required this.local,
      this.motorista,
      this.veiculo,
      this.horaInicio,
      this.horaTermino,
      this.policiamento,
      this.promotoria,
      this.promotor,
      required this.usuario});

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'dataInicial': dataInicial,
      'dataFinal': dataFinal,
      'local': local,
      'motorista': motorista,
      'veiculo': veiculo,
      'horaInicio': horaInicio,
      'horaTermino': horaTermino,
      'policiamento': policiamento,
      'promotoria': promotoria,
      'promotor': promotor,
      'usuario': usuario
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
        dataInicial: data?['dataInicial']?.toDate(),
        dataFinal: data?['dataFinal']?.toDate(),
        local: data?['local'],
        motorista: data?['motorista'],
        veiculo: data?['veiculo'],
        horaInicio: data?['horaInicio']?.toDate(),
        horaTermino: data?['horaTermino']?.toDate(),
        policiamento: data?['policiamento'],
        promotoria: data?['promotoria'],
        promotor: data?['promotor'],
        usuario: data?['usuario']);
  }
  @override
  String toString() {
    return 'Id: ${id ?? '?'} | DataInicial: $dataInicial | DataFinal: $dataFinal  | Local: $local | Motorista: $motorista | Veiculo: $veiculo | Usuario: $usuario';
  }

  Agendamento copywith() {
    return Agendamento(
        id: id,
        criacao: criacao,
        dataInicial: dataInicial,
        dataFinal: dataFinal,
        local: local,
        motorista: motorista,
        veiculo: veiculo,
        horaInicio: horaInicio,
        horaTermino: horaTermino,
        policiamento: policiamento,
        promotoria: promotoria,
        promotor: promotor,
        usuario: usuario);
  }
}
