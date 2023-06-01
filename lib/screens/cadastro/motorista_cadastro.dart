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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira Nome';
                    }
                    return null;
                  },
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
            if (_formKey.currentState!.validate()) {
              dao.salvar(motorista);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso')),
              );
            }
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
