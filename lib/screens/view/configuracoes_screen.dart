import 'package:agendamentos_app/screens/calendar/cores.dart';
import 'package:agendamentos_app/screens/view/teste.dart';
import 'package:flutter/material.dart';
import '../../services/change_password.dart';
import 'tema_screen.dart';

class Configuracoes extends StatelessWidget {
  final Configuracoes? configuracoes;
  const Configuracoes({super.key, this.configuracoes});

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
          ),
          ListTile(
            leading: const Icon(Icons.phone_android_rounded),
            title: const Text('Cores'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cores(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text('Cores'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Teste(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
