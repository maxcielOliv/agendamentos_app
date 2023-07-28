import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:agendamentos_app/screens/calendar/calendario.dart';
import 'package:flutter/material.dart';

import '../calendar/agendamento_editor.dart';

class AgendamentoScreen extends StatelessWidget {
  final AgendamentoScreen? agendamentoScreen;
  const AgendamentoScreen({super.key, this.agendamentoScreen});

  @override
  Widget build(BuildContext context) {
    final dao = AgendamentoDao();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AgendamentoCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Agendamento>>(
        stream: dao.getAllStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          final lista = snapshot.data ?? [];
          return ListView.separated(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final agendamento = lista[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgendamentoEditor(
                        agendamentoValor: agendamento,
                      ),
                    ),
                  );
                },
                title: Text(agendamento.local),
                subtitle: Text('${agendamento.dataInicial}'),
                trailing: IconButton(
                  onPressed: () {
                    dao.deletar(agendamento);
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 0,
            ),
          );
        },
      ),
    );
  }
}
