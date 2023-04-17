import 'package:flutter/material.dart';

class AgendamentoCadastro extends StatelessWidget {
  const AgendamentoCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Data',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Local',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Veiculo',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Hora Inicio',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Hora Fim',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Policiamento',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Promotoria',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Promotor',
                  icon: Icon(Icons.today),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
