import 'package:agendamentos_app/utils/temas/dark_theme.dart';
import 'package:flutter/material.dart';

class TemaScreen extends StatefulWidget {
  const TemaScreen({super.key});

  @override
  State<TemaScreen> createState() => _TemaScreenState();
}

List<ThemeData> temas = [temaEscuro, temaEscuro];

class _TemaScreenState extends State<TemaScreen> {
  ThemeData temaSelecionado = temas[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Temas'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Dark'),
            leading: Radio(
              value: temas[0],
              groupValue: temaSelecionado,
              onChanged: (value) {
                setState(
                  () {
                    temaSelecionado = value!;
                  },
                );
              },
            ),
          ),
          ListTile(
            title: const Text('Light'),
            leading: Radio(
              value: temas[1],
              groupValue: temaSelecionado,
              onChanged: (value) {
                setState(
                  () {
                    temaSelecionado = value!;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
