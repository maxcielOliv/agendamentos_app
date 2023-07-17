import 'dart:math';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../database/models/agendamento.dart';
import '../../database/models/dao/agendamento_dao.dart';
import '../../database/models/dao/motorista_dao.dart';
import '../../database/models/dao/promotor_dao.dart';
import '../../database/models/dao/promotoria_dao.dart';
import '../../database/models/dao/veiculo_dao.dart';
import '../../database/models/motorista.dart';
import '../../database/models/promotor.dart';
import '../../database/models/promotoria.dart';
import '../../database/models/veiculo.dart';
import 'cores.dart';

class AgendamentoEditor extends StatefulWidget {
  final Agendamento? agendamento;
  const AgendamentoEditor({super.key, this.agendamento});

  @override
  AgendamentoEditorState createState() => AgendamentoEditorState();
}

class AgendamentoEditorState extends State<AgendamentoEditor> {
  final separador = const SizedBox(height: 10);
  bool policiamento = false;
  final _formKey = GlobalKey<FormState>();
  final dao = AgendamentoDao();
  final _local = TextEditingController();
  final _dataInicialControle = TextEditingController();
  final _dataFinalControle = TextEditingController();
  final _inicio = TextEditingController();
  final _termino = TextEditingController();
  final _veiculo = TextEditingController();
  final _motorista = TextEditingController();
  final _policiamento = TextEditingController();
  final _promotoria = TextEditingController();
  final _promotor = TextEditingController();
  final motoristaDao = MotoristaDao();
  final veiculoDao = VeiculoDao();
  final promotoriaDao = PromotoriaDao();
  final promotorDao = PromotorDao();
  //final _usuario = AuthService().user;
  late Agendamento agendamento = Agendamento(
    local: _local.text,
    dataInicial: _dataInicial,
    dataFinal: _dataFinal,
    horaInicio: DateTime(_dataInicial.year, _dataInicial.month,
        _dataInicial.day, _horaInicio.hour, _horaInicio.minute),
    horaTermino: DateTime(_dataFinal.year, _dataFinal.month, _dataFinal.day,
        _horaTermino.hour, _horaTermino.minute),
    motorista: _motorista.text,
    policiamento: _policiamento.text,
    promotor: _promotor.text,
    promotoria: _promotoria.text,
    veiculo: _veiculo.text,
  );

  CalendarController calendarController = CalendarController();
  late DateTime _dataInicial = DateTime.now();
  late DateTime _dataFinal = DateTime.now();
  late TimeOfDay _horaInicio = TimeOfDay.now();
  late TimeOfDay _horaTermino = TimeOfDay.now();
  DateTimeRange selecionaRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  @override
  Widget build(BuildContext context) {
    List<Color> _colorCollection = <Color>[];
    List<String> _colorNames = <String>[];
    int _selectedColorIndex = 0;
    return Scaffold(
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
            padding: const EdgeInsets.only(right: 24),
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
                        content: Text('Ocorreu um Erro!'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _local,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                  label: Text('Local'),
                  hintText: 'Local do agendamento',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um local';
                  }
                  return null;
                },
              ),
              separador,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dataInicialControle,
                      keyboardType: TextInputType.multiline,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.date_range_rounded),
                          onPressed: () async {
                            final DateTimeRange? date =
                                await showDateRangePicker(
                              context: context,
                              initialDateRange: selecionaRange,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (date != null) {
                              selecionaRange = date;
                              _dataInicial = date.start;
                              _dataInicialControle.text =
                                  DateFormat('d/M/y').format(date.start);
                              print(_dataInicialControle);
                            }
                          },
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text('Data Inicial'),
                        hintText: 'dd/mm/aaaa',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe uma data';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _dataInicialControle,
                      keyboardType: TextInputType.multiline,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.date_range_rounded),
                          onPressed: () async {
                            final DateTimeRange? date =
                                await showDateRangePicker(
                                    context: context,
                                    initialDateRange: selecionaRange,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                            if (date != null) {
                              selecionaRange = date;
                              _dataFinal = date.end;
                              _dataInicialControle.text =
                                  DateFormat('d/M/y').format(date.end);
                            }
                          },
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text('Data Final'),
                        hintText: 'dd/mm/aaaa',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe uma data';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              separador,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _inicio,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        HoraInputFormatter(),
                      ],
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.access_time_rounded),
                          onPressed: () async {
                            final TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: _horaInicio,
                            );
                            if (time != null) {
                              setState(() {
                                _horaInicio = time;
                                _inicio.text = time.format(context);
                              });
                            }
                          },
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text('Início'),
                        hintText: 'hh:mm',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe uma hora';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _termino,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        HoraInputFormatter(),
                      ],
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.access_time_rounded),
                          onPressed: () async {
                            final TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: _horaTermino,
                            );
                            if (time != null) {
                              setState(
                                () {
                                  _horaTermino = time;
                                  _termino.text = time.format(context);
                                },
                              );
                            }
                          },
                        ),
                        border: const OutlineInputBorder(),
                        label: const Text('Término'),
                        hintText: 'hh:mm',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe uma hora';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              separador,
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
                      isExpanded: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.drive_eta_outlined),
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
                      isExpanded: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.sports_motorsports_outlined),
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
                      isExpanded: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home_outlined),
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
                      isExpanded: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_2_rounded),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: policiamento,
                    onChanged: (bool? value) {
                      setState(() {
                        policiamento = value!;
                        _policiamento.text = policiamento.toString();
                      });
                    },
                  ),
                  const Text('Policiamento')
                ],
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: Icon(Icons.lens,
                    color: _colorCollection[_selectedColorIndex]),
                title: Text(
                  _colorNames[_selectedColorIndex],
                ),
                onTap: () {
                  showDialog<Widget>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return ColorPicker();
                    },
                  ).then(
                    (dynamic value) => setState(
                      () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
