import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:agendamentos_app/screens/cadastro/motorista_cadastro.dart';
import 'package:flutter/material.dart';

class MotoristaScreen extends StatefulWidget {
  const MotoristaScreen({super.key});

  @override
  State<MotoristaScreen> createState() => _PromotoriaScreenState();
}

class _PromotoriaScreenState extends State<MotoristaScreen> {
  final _controller = TextEditingController();
  final dao = MotoristaDao();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motorista'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MotoristaCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Motorista>>(
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
                final motorista = lista[index];
                return ListTile(
                  title: Text(motorista.nome),
                  subtitle: Text('${motorista.criacao}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MotoristaCadastro(),
                      ),
                    );
                  },
                  trailing: IconButton(
                    onPressed: () {
                      dao.deletar(motorista);
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
