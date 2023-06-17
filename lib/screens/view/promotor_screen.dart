import 'package:agendamentos_app/database/models/dao/promotor_dao.dart';
import 'package:agendamentos_app/database/models/promotor.dart';
import 'package:agendamentos_app/screens/cadastro/promotor_cadastro.dart';
import 'package:flutter/material.dart';

class PromotorScreen extends StatefulWidget {
  const PromotorScreen({super.key});

  @override
  State<PromotorScreen> createState() => _PromotorScreenState();
}

class _PromotorScreenState extends State<PromotorScreen> {
  final _controller = TextEditingController();
  final dao = PromotorDao();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotor'),
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
                  title: Text(promotor.nome),
                  subtitle: Text(promotor.matricula),
                  trailing: IconButton(
                    onPressed: () {
                      dao.deletar(promotor);
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
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
