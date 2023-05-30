import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:flutter/material.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dao = AgendamentoDao();
  final _local = TextEditingController();
  final _motorista = TextEditingController();
  final _veiculo = TextEditingController();
  final DateTime _startDate = DateTime.now();
  final DateTime _endDate = DateTime.now();
  late Agendamento agendamento = Agendamento(
      data: DateTime.now(),
      local: _local.text,
      motorista: _motorista.text,
      veiculo: _veiculo.text,
      horaInicio: _startDate,
      horaTermino: _endDate);

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Agendamento salvo com sucesso.'),
          actions: [
            TextButton(
              onPressed: () {
                dao.salvar(agendamento);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Agendamento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Data'),
                subtitle: Text(_selectedDate.toString()),
                onTap: _showDatePicker,
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Hora Inicio'),
                subtitle: Text(_selectedTime.format(context)),
                onTap: _showTimePicker,
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Hora Término'),
                subtitle: Text(_selectedTime.format(context)),
                onTap: _showTimePicker,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Local',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, digite o local';
                  }
                  return null;
                },
                onSaved: (value) {
                  _local.text = value!;
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Notas',
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Por favor, digite as notas';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     _notes = value!;
              //   },
              // ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}
