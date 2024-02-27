import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:agendamentos_app/screens/cadastro/promotoria_cadastro.dart';
import 'package:flutter/material.dart';

//Página de promotoria
//Mostra todas as promotorias cadastradas

class PromotoriaScreen extends StatelessWidget {
  final Promotoria? promotoria;
  const PromotoriaScreen({super.key, this.promotoria});

  @override
  Widget build(BuildContext context) {
    final dao = PromotoriaDao();
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PromotoriaCadastro(
                          promotoriaValor: promotoria,
                        ),
                      ),
                    );
                  },
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
