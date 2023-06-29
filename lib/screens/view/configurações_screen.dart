// ignore: file_names
import 'package:agendamentos_app/screens/view/tema_screen.dart';
import 'package:flutter/material.dart';

import '../../services/change_password.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    const separador = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          separador,
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Alterar senha'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePassword(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android_rounded),
            title: const Text('Temas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TemaScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
