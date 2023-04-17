import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:flutter/material.dart';

class MotoristaCadastro extends StatefulWidget {
  const MotoristaCadastro({super.key});

  @override
  State<MotoristaCadastro> createState() => _MotoristaCadastroState();
}

class _MotoristaCadastroState extends State<MotoristaCadastro> {
  final _nome = TextEditingController();
  late Motorista motorista = Motorista(nome: _nome.text);
  final dao = MotoristaDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Motorista'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nome,
                // showCursor: true,
                // readOnly: true,
                keyboardType: TextInputType.name,
                validator: (value) {},
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.near_me),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          dao.salvar(motorista);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
