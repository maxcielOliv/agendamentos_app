import 'package:agendamentos_app/database/models/dao/usuario_dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/screens/cadastro/usuario_cadastro.dart';
import 'package:flutter/material.dart';

class UsuarioScreen extends StatelessWidget {
  final Usuario? usuario;
  const UsuarioScreen({super.key, this.usuario});

  @override
  Widget build(BuildContext context) {
    final dao = UsuarioDao();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
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
                  builder: (context) => const UsuarioCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Usuario>>(
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
                final usuario = lista[index];
                return ListTile(
                  title: Text(usuario.nome.toString()),
                  subtitle: Text(usuario.lotacao.toString()),
                  trailing: IconButton(
                    onPressed: () async {
                      await dao.deletar(usuario);
                      //_auth.deletar();
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                  onTap: () {},
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
