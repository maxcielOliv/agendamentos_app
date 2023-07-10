import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/screens/calendar/agendamento_Editor.dart';
import 'package:flutter/material.dart';
import '../../database/models/veiculo.dart';
import '../view/agendamento_screen.dart';

class MultCalendarios extends StatefulWidget {
  const MultCalendarios({Key? key}) : super(key: key);

  @override
  State<MultCalendarios> createState() => _MultCalendariosState();
}

final dao = VeiculoDao();

class _MultCalendariosState extends State<MultCalendarios> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Agendamentos'),
      ),
      body: FutureBuilder<List<Veiculo>>(
        future: dao.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro ao carregar!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          if (data != null) {
            return ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final veiculo = data[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.blue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(veiculo.modelo.toUpperCase()),
                          subtitle: Text(veiculo.placa.toUpperCase()),
                        ),
                        ListTile(
                          title: const Text('MOTORISTA'),
                          subtitle:
                              Text(veiculo.motorista.toString().toUpperCase()),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DropdownPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Text('Sem dados');
        },
      ),
    );
  }
}
