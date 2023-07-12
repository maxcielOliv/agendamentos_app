import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:agendamentos_app/database/models/dao/promotor_dao.dart';
import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:agendamentos_app/database/models/veiculo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../database/models/promotor.dart';

class AgendamentoEditor extends StatefulWidget {
  const AgendamentoEditor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgendamentoEditorState createState() => _AgendamentoEditorState();
}

class _AgendamentoEditorState extends State<AgendamentoEditor> {
  final separador = const SizedBox(height: 10);
  bool policiamento = false;
  final _formKey = GlobalKey<FormState>();
  final dao = AgendamentoDao();
  final _local = TextEditingController();
  final _veiculo = TextEditingController();
  final _motorista = TextEditingController();
  final _policiamento = TextEditingController();
  final _promotoria = TextEditingController();
  final _promotor = TextEditingController();
  final motoristaDao = MotoristaDao();
  final veiculoDao = VeiculoDao();
  final promotoriaDao = PromotoriaDao();
  final promotorDao = PromotorDao();
  late Agendamento agendamento = Agendamento(
    local: _local.text,
    policiamento: _policiamento.text,
    veiculo: _veiculo.text,
    motorista: _motorista.text,
    promotoria: _promotoria.text,
    promotor: _promotor.text,
    data: _startDate,
    horaInicio: DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute),
    horaTermino: DateTime(_startDate.year, _startDate.month, _startDate.day,
        _endTime.hour, _endTime.minute),
  );
  CalendarController calendarController = CalendarController();
  late DateTime _startDate = DateTime.now();
  late TimeOfDay _startTime = TimeOfDay.now();
  late TimeOfDay _endTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Novo Agendamento'),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (await dao.salvar(agendamento)) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cadastro realizado com sucesso'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Conclua o cadastro'),
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(5),
                leading: const Icon(
                  Icons.home,
                  color: Colors.black87,
                ),
                title: TextFormField(
                  controller: _local,
                  onChanged: (String value) {
                    _local.text = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um nome';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Adicione o Local',
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Icon(
                  Icons.date_range_rounded,
                  color: Colors.black54,
                ),
                title: SafeArea(
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Text(DateFormat('d/M/y').format(_startDate),
                          textAlign: TextAlign.left),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(
                            () {
                              _startDate = date!;
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Icon(
                  Icons.access_time,
                  color: Colors.black54,
                ),
                title: SafeArea(
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Text('$_startTime'),
                      onTap: () async {
                        final TimeOfDay? horaInicial = await showTimePicker(
                          context: context,
                          initialTime: _startTime,
                        );
                        if (horaInicial != null) {
                          setState(
                            () {
                              _startTime = horaInicial;
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Icon(
                  Icons.access_time,
                  color: Colors.black54,
                ),
                title: SafeArea(
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Text('$_endTime'),
                      onTap: () async {
                        final TimeOfDay? horaFinal = await showTimePicker(
                          context: context,
                          initialTime: _endTime,
                        );
                        if (horaFinal != null) {
                          setState(
                            () {
                              _endTime = horaFinal;
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              StreamBuilder<List<Veiculo>>(
                stream: veiculoDao.getAllStream(),
                builder: (context, snapshots) {
                  List<DropdownMenuItem<String>> veiculoItens = [];
                  if (!snapshots.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final veiculos = snapshots.data?.reversed.toList();
                    for (var veiculo in veiculos!) {
                      veiculoItens.add(
                        DropdownMenuItem(
                          value: veiculo.modelo,
                          child: Text(veiculo.modelo.toString()),
                        ),
                      );
                    }
                  }
                  return SizedBox(
                    width: 280,
                    child: DropdownButtonFormField<String>(
                      icon: const Icon(Icons.drive_eta_outlined),
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Veiculo'),
                      items: veiculoItens,
                      onChanged: (String? motoristaValue) {
                        _veiculo.text = motoristaValue!;
                      },
                    ),
                  );
                },
              ),
              separador,
              StreamBuilder<List<Motorista>>(
                stream: motoristaDao.getAllStream(),
                builder: (context, snapshots) {
                  List<DropdownMenuItem<String>> motoristaItens = [];
                  if (!snapshots.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final motoristas = snapshots.data?.reversed.toList();
                    for (var motorista in motoristas!) {
                      motoristaItens.add(
                        DropdownMenuItem(
                          value: motorista.nome,
                          child: Text(motorista.nome.toString()),
                        ),
                      );
                    }
                  }
                  return SizedBox(
                    width: 280,
                    child: DropdownButtonFormField(
                      icon: const Icon(Icons.sports_motorsports_outlined),
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Motorista'),
                      items: motoristaItens,
                      onChanged: (String? veiculoValue) {
                        _motorista.text = veiculoValue!;
                      },
                    ),
                  );
                },
              ),
              separador,
              StreamBuilder<List<Promotoria>>(
                stream: promotoriaDao.getAllStream(),
                builder: (context, snapshots) {
                  List<DropdownMenuItem<String>> promotoriaItens = [];
                  if (!snapshots.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final promotorias = snapshots.data?.reversed.toList();
                    for (var promotoria in promotorias!) {
                      promotoriaItens.add(
                        DropdownMenuItem(
                          value: promotoria.nome,
                          child: Text(promotoria.nome.toString()),
                        ),
                      );
                    }
                  }
                  return SizedBox(
                    width: 280,
                    child: DropdownButtonFormField(
                      icon: const Icon(Icons.home_outlined),
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Promotoria'),
                      items: promotoriaItens,
                      onChanged: (String? promotoriaValue) {
                        _promotoria.text = promotoriaValue!;
                      },
                    ),
                  );
                },
              ),
              separador,
              StreamBuilder<List<Promotor>>(
                stream: promotorDao.getAllStream(),
                builder: (context, snapshots) {
                  List<DropdownMenuItem<String>> promotorItens = [];
                  if (!snapshots.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final promotores = snapshots.data?.reversed.toList();
                    for (var promotor in promotores!) {
                      promotorItens.add(
                        DropdownMenuItem(
                          value: promotor.nome,
                          child: Text(promotor.nome.toString()),
                        ),
                      );
                    }
                  }
                  return SizedBox(
                    width: 280,
                    child: DropdownButtonFormField(
                      icon: const Icon(Icons.person_2_rounded),
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Promotor'),
                      items: promotorItens,
                      onChanged: (String? promotorValue) {
                        _promotor.text = promotorValue!;
                      },
                    ),
                  );
                },
              ),
              separador,
              FilterChip(
                label: const Text('Policiamento'),
                selected: policiamento,
                onSelected: (bool value) {
                  setState(
                    () {
                      policiamento = !policiamento;
                      _policiamento.text = policiamento.toString();
                    },
                  );
                },
              ),
              const Divider(
                height: 1.0,
                thickness: 1,
              ),
              const Divider(
                height: 1.0,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
