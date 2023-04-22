import 'package:agendamentos_app/database/models/dao/usuario_dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/screens/cadastro/veiculos_cadastro.dart';
import 'package:flutter/material.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _controller = TextEditingController();
  final dao = UsuarioDao();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
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
      body: FutureBuilder<List<Usuario>>(
          future: dao.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            final lista = snapshot.data;
            if (lista != null) {
              return ListView.separated(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  final usuario = lista[index];
                  return ListTile(
                    title: Text(usuario.usuario),
                    subtitle: Text(usuario.criacao.toString()),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
              );
            }
            return const Text('Sem dados');
          }),
    );
  }
}
