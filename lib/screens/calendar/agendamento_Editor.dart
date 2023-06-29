import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:agendamentos_app/database/models/veiculo.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  final separador = const SizedBox(height: 10);
  bool policiamento = false;
  final _formKey = GlobalKey<FormState>();
  final dao = AgendamentoDao();
  final _local = TextEditingController();
  final _veiculo = TextEditingController();
  final _motorista = TextEditingController();
  final _policiamento = TextEditingController();
  final motoristaDao = MotoristaDao();
  final veiculoDao = VeiculoDao();
  late Agendamento agendamento = Agendamento(
      local: _local.text,
      policiamento: _policiamento.text,
      veiculo: _veiculo.text,
      motorista: _motorista.text,
      data: DateTime.now(),
      horaInicio: DateTime.now(),
      horaTermino: DateTime.now());
  CalendarController calendarController = CalendarController();
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  @override
  void initState() {
    super.initState();
    // _startDate.day;
    // _endDate.day;
    // _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    // _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
  }

  @override
  Widget build(BuildContext context) {
    return
        /*Form(
      key: _formKey,
      child: */
        Scaffold(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cadastro realizado com sucesso'),
                  ),
                );
                dao.salvar(agendamento);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: const Icon(
                Icons.home,
                color: Colors.black87,
              ),
              title: TextField(
                controller: TextEditingController(text: _local.text),
                onChanged: (String value) {
                  _local.text = value;
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
            separador,
            /*ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: const Text(''),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      child: Text(
                          DateFormat('EEE, MMM dd yyyy').format(_startDate),
                          textAlign: TextAlign.left),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (date != null && date != _startDate) {
                          setState(
                            () {
                              final Duration difference =
                                  _endDate.difference(_startDate);
                              _startDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  _startTime.hour,
                                  _startTime.minute,
                                  0);
                              _endDate = _startDate.add(difference);
                              _endTime = TimeOfDay(
                                  hour: _endDate.hour, minute: _endDate.minute);
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                    leading: const Text(''),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: GestureDetector(
                            child: Text(
                              DateFormat('EEE, MMM dd yyyy').format(_endDate),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != _endDate) {
                                setState(
                                  () {
                                    final Duration difference =
                                        _endDate.difference(_startDate);
                                    _endDate = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        _endTime.hour,
                                        _endTime.minute,
                                        0);
                                    if (_endDate.isBefore(_startDate)) {
                                      _startDate =
                                          _endDate.subtract(difference);
                                      _startTime = TimeOfDay(
                                          hour: _startDate.hour,
                                          minute: _startDate.minute);
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ),*/
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
                    //onSaved: (veiculo) => agendamento.veiculo = veiculo,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Veiculo'),
                    items: veiculoItens,
                    onChanged: (String? motoristaValue) {
                      print(motoristaValue);
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
                    //onSaved: (motorista) => agendamento.motorista = motorista,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Motorista'),
                    items: motoristaItens,
                    onChanged: (String? veiculoValue) {
                      print(veiculoValue);
                      _motorista.text = veiculoValue!;
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
    );
    //);
  }
}
