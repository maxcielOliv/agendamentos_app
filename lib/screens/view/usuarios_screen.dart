import 'package:agendamentos_app/database/models/dao/usuario_dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/screens/cadastro/usuario_cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _controller = TextEditingController();
  final dao = UsuarioDao();
  final _firebaseAuth = FirebaseAuth.instance.authStateChanges().listen(
    (User? user) {
      if (user != null) {
        user.delete();
      }
    },
  );

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
                  title: Text(usuario.nome),
                  subtitle: Text(usuario.id.toString()),
                  trailing: IconButton(
                    onPressed: () async {
                      await dao.deletar(usuario);
                      _firebaseAuth;
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
