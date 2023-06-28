import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:agendamentos_app/screens/cadastro/promotoria_cadastro.dart';
import 'package:flutter/material.dart';

class PromotoriaScreen extends StatefulWidget {
  const PromotoriaScreen({super.key});

  @override
  State<PromotoriaScreen> createState() => _PromotoriaScreenState();
}

class _PromotoriaScreenState extends State<PromotoriaScreen> {
  final _controller = TextEditingController();
  final dao = PromotoriaDao();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotorias de Justiça / Coordenação'),
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
                  builder: (context) => const PromotoriaCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Promotoria>>(
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
                final promotoria = lista[index];
                return ListTile(
                  title: Text(promotoria.nome),
                  subtitle: Text('${promotoria.criacao}'),
                  trailing: IconButton(
                    onPressed: () {
                      dao.deletar(promotoria);
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
