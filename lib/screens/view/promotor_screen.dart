import 'package:agendamentos_app/database/models/dao/promotor_dao.dart';
import 'package:agendamentos_app/database/models/promotor.dart';
import 'package:agendamentos_app/screens/cadastro/promotor_cadastro.dart';
import 'package:flutter/material.dart';

class PromotorScreen extends StatelessWidget {
  final Promotor? promotor;
  const PromotorScreen({super.key, this.promotor});

  @override
  Widget build(BuildContext context) {
    final dao = PromotorDao();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotores de Justiça'),
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
                  builder: (context) => const PromotorCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Promotor>>(
        stream: dao.getAllStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          final lista = snapshot.data;
          if (lista != null) {
            return ListView.separated(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final promotor = lista[index];
                return ListTile(
                  title: Text(promotor.nome.toString()),
                  subtitle: Text(promotor.lotacao.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      dao.deletar(promotor);
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PromotorCadastro(
                          promotorValor: promotor,
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
            );
          }
          return const Text('Sem dados');
        },
      ),
    );
  }
}
