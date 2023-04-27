import 'package:agendamentos_app/app.dart';
import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';

import 'package:agendamentos_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());

  // final agendamento = Agendamento(
  //     data: DateTime.now(),
  //     local: 'Esperançinha',
  //     motorista: 'marcelo',
  //     veiculo: 'gol',
  //     horaInicio: DateTime.now(),
  //     horaTermino: DateTime.now());
  // final dao = AgendamentoDao();
  // dao.salvar(agendamento);
}
