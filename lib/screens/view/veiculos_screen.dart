import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/database/models/veiculo.dart';
import 'package:agendamentos_app/screens/cadastro/veiculos_cadastro.dart';
import 'package:flutter/material.dart';

class VeiculoScreen extends StatelessWidget {
  final Veiculo? veiculo;
  const VeiculoScreen({super.key, this.veiculo});

  @override
  Widget build(BuildContext context) {
    final dao = VeiculoDao();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos'),
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
                  builder: (context) => const VeiculosCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Veiculo>>(
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
                final veiculo = lista[index];
                return ListTile(
                  title: Text(veiculo.modelo),
                  subtitle: Text(veiculo.placa),
                  trailing: IconButton(
                    onPressed: () {
                      dao.deletar(veiculo);
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VeiculosCadastro(
                          veiculoValor: veiculo,
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
