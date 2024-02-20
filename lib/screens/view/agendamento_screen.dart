import 'package:agendamentos_app/database/models/agendamento.dart';
import 'package:agendamentos_app/database/models/dao/agendamento_dao.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
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
          AuthService().adminEnabled || AuthService().agendEnabled
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AgendamentoEditor(),
                        ));
                  },
                )
              : const SizedBox()
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
                      builder: (context) => const AgendamentoEditor(
                          //agendamentoValor: agendamento,
                          ),
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${agendamento.veiculo?.toUpperCase()}'),
                    Text('${agendamento.promotoria}'),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Missão: ${agendamento.local .toString()}', style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text('Data: ${agendamento.dataInicial.toString()}'),
                  ],
                ),
                trailing: AuthService().adminEnabled
                        ? IconButton(
                          icon: const Icon(Icons.delete_forever_rounded),
                          onPressed: () {
                            dao.deletar(agendamento);
                          },
                        )
                        : const SizedBox()
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 0,
            ),
          );
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: AuthService().adminEnabled 
                ? () => print('admin ok')
                : () => print('vc não é admin')
      ),*/
    );
  }
}
