import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  bool policiamento = false;
  List<dynamic> _listaVazia = [];
  String dropdownValue = 'Sim';
  final _formKey = GlobalKey<FormState>();
  final dao = AgendamentoDao();
  final motoristaDao = MotoristaDao();
  final _local = TextEditingController();
  CalendarController calendarController = CalendarController();
  // late DateTime _startDate = DateTime(1900);
  // late DateTime _endDate = DateTime(2100);
  // DateTime _selectedDate = DateTime.now();
  // TimeOfDay _selectedTime = TimeOfDay.now();
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  @override
  void initState() {
    super.initState();
    _getMotorista();
    _getVeiculo();
    // _startDate.day;
    // _endDate.day;
    // _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    // _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
  }

  void _getMotorista() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('motorista').get();

    final List<DocumentSnapshot> documents = result.docs;
    setState(
      () {
        _listaVazia = documents.map((doc) => doc['nome']).toList();
      },
    );
  }

  void _getVeiculo() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('veiculo').get();

    final List<DocumentSnapshot> documents = result.docs;
    setState(
      () {
        _listaVazia = documents.map((doc) => doc['marca']).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _selecionaMotorista = _listaVazia.first;
    //String _selecionaVeiculos = _listaVazia.first;
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
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso')),
              );
              //dao.salvar(agendamento);
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
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
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
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
              child: Text('Selecione o motorista'),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            DropdownButtonFormField(
              value: _selecionaMotorista,
              items: _listaVazia.map(
                (category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(
                  () {
                    _selecionaMotorista = value.toString();
                  },
                );
              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
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
            /*DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.menu),
              underline: Container(
                height: 2,
              ),
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdownValue = newValue!;
                  },
                );
              },
              items: const [
                DropdownMenuItem(
                  value: 'Sim',
                  child: Text('Sim'),
                ),
                DropdownMenuItem(
                  value: 'Não',
                  child: Text('Não'),
                )
              ],
            ),*/
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
              child: Text('Selecione o veículo'),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            /*DropdownButtonFormField(
              value: dropdownValue,
              items: _listaVazia.map(
                (category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(
                  () {
                    //_selecionaVeiculos = value.toString();
                    dropdownValue;
                  },
                );
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              'Selecione o motorista: $_selecionaMotorista',
              style: const TextStyle(fontSize: 16.0),
            ),*/
          ],
        ),
      ),
      //],
    );
    //),
    // ],
    //),
    //),
    //);
  }
}
