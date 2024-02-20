import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/screens/calendar/agendamento_editor.dart';
import 'package:agendamentos_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../database/models/veiculo.dart';

class MultCalendarios extends StatefulWidget {
  const MultCalendarios({Key? key}) : super(key: key);

  @override
  State<MultCalendarios> createState() => _MultCalendariosState();
}

final dao = VeiculoDao();

class _MultCalendariosState extends State<MultCalendarios> {
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
                          subtitle: Text(veiculo.motorista.toString().toUpperCase()),
                          trailing: AuthService().adminEnabled || AuthService().agendEnabled
                                  ? IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AgendamentoEditor(),
                                        )
                                      );
                                    },
                                  )
                                : SizedBox() 
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
