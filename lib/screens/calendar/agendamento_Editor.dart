import 'package:agendamentos_app/screens/calendar/cores.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
import '../../services/auth_service.dart';

class AgendamentoEditor extends StatelessWidget {
  final Agendamento? agendamentoValor;
  const AgendamentoEditor({super.key, this.agendamentoValor});
  final separador = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final dataInicial = ValueNotifier<DateTime>(
        agendamentoValor!.dataInicial ?? DateTime.now());
    final dataFinal = ValueNotifier<DateTime>(DateTime.now());
    final horaInicio = ValueNotifier<TimeOfDay>(TimeOfDay.now());
    final horaTermino = ValueNotifier<TimeOfDay>(TimeOfDay.now());

    final isPoliciamento = ValueNotifier<bool>(false);
    final formKey = GlobalKey<FormState>();
    final dao = AgendamentoDao();
    final local = TextEditingController(text: agendamentoValor?.local);
    final dataInicialControle = TextEditingController();
    final dataFinalControle = TextEditingController();
    final inicio = TextEditingController();
    final termino = TextEditingController();
    final veiculoControler =
        TextEditingController(text: agendamentoValor?.veiculo);
    final motorista = TextEditingController(text: agendamentoValor?.motorista);
    final policiamento = TextEditingController();
    final promotoria =
        TextEditingController(text: agendamentoValor?.promotoria);
    final promotor = TextEditingController(text: agendamentoValor?.promotor);
    final motoristaDao = MotoristaDao();
    final veiculoDao = VeiculoDao();
    final promotoriaDao = PromotoriaDao();
    final promotorDao = PromotorDao();
    final usuario = AuthService().user;
    late Agendamento agendamento = Agendamento(
      id: agendamentoValor?.id,
      local: local.text,
      dataInicial: dataInicial.value,
      dataFinal: dataFinal.value,
      horaInicio: DateTime(
          dataInicial.value.year,
          dataInicial.value.month,
          dataInicial.value.day,
          horaInicio.value.hour,
          horaInicio.value.minute),
      horaTermino: DateTime(
          dataFinal.value.year,
          dataFinal.value.month,
          dataFinal.value.day,
          horaTermino.value.hour,
          horaTermino.value.minute),
      motorista: motorista.text,
      policiamento: policiamento.text,
      promotor: promotor.text,
      promotoria: promotoria.text,
      veiculo: veiculoControler.text,
      usuario: usuario!.nome.toString(),
    );
    print(usuario!.nome);
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
              if (formKey.currentState!.validate()) {
                if (await dao.salvar(agendamento)) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                            'Cadastro ${agendamento.id == null ? 'criado' : 'atualizado'} com sucesso'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                } else {
                  if (context.mounted) {
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
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: local,
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
                    child: AnimatedBuilder(
                        animation: dataInicial,
                        builder: (context, child) {
                          return TextFormField(
                            controller: dataInicialControle,
                            keyboardType: TextInputType.multiline,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              //labelText: 'Data Inicial',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.date_range_rounded),
                                onPressed: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: dataInicial.value,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (date != null) {
                                    dataInicial.value = date;
                                    dataInicialControle.text =
                                        //DateFormat('d/M/y').format(date);
                                        DateFormat.yMd('pt_BR').format(date);
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
                          );
                        }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AnimatedBuilder(
                        animation: dataFinal,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: dataFinalControle,
                            keyboardType: TextInputType.multiline,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              //labelText: 'Data Final',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.date_range_rounded),
                                onPressed: () async {
                                  final DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: dataFinal.value,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    dataFinal.value = date;
                                    dataFinalControle.text =
                                        //DateFormat('d/M/y').format(date);
                                        DateFormat.yMd('pt_BR').format(date);
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
                          );
                        }),
                  ),
                ],
              ),
              separador,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: AnimatedBuilder(
                        animation: horaInicio,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: inicio,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              HoraInputFormatter(),
                            ],
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              //labelText: 'Hora Inicio',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.access_time_rounded),
                                onPressed: () async {
                                  final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: horaInicio.value,
                                  );
                                  if (time != null) {
                                    horaInicio.value = time;
                                    inicio.text = time.format(context);
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
                          );
                        }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AnimatedBuilder(
                        animation: horaTermino,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: termino,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              HoraInputFormatter(),
                            ],
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              //labelText: 'Hora Término',
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.access_time_rounded),
                                onPressed: () async {
                                  final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: horaTermino.value,
                                  );
                                  if (time != null) {
                                    horaTermino.value = time;
                                    termino.text = time.format(context);
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
                          );
                        }),
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
                    child: DropdownButtonFormField(
                      //value: agendamentoValor?.veiculo,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.drive_eta_outlined),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Veiculo'),
                      items: veiculoItens,
                      onChanged: (String? veiculoValue) {
                        veiculoControler.text = veiculoValue!;
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
                      value: agendamentoValor?.motorista,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        //labelText: 'Motorista',
                        prefixIcon: Icon(Icons.sports_motorsports_outlined),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Motorista'),
                      items: motoristaItens,
                      onChanged: (String? veiculoValue) {
                        motorista.text = veiculoValue!;
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
                      value: agendamentoValor?.promotoria,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        //labelText: 'Promotoria',
                        prefixIcon: Icon(Icons.home_outlined),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Promotoria'),
                      items: promotoriaItens,
                      onChanged: (String? promotoriaValue) {
                        promotoria.text = promotoriaValue!;
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
                      value: agendamentoValor?.promotor,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        //labelText: 'Promotor',
                        prefixIcon: Icon(Icons.person_2_rounded),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Promotor'),
                      items: promotorItens,
                      onChanged: (String? promotorValue) {
                        promotor.text = promotorValue!;
                      },
                    ),
                  );
                },
              ),
              separador,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: isPoliciamento,
                      builder: (context, snapshot) {
                        return Checkbox(
                          value: isPoliciamento.value,
                          onChanged: (bool? value) {
                            isPoliciamento.value = value!;
                            policiamento.text = isPoliciamento.toString();
                          },
                        );
                      }),
                  const Text('Policiamento')
                ],
              ),
              separador,
              ListTile(
                title: const Text('Prioridade'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Cores(),
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
