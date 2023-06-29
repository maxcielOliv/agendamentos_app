import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:flutter/material.dart';

class PromotoriaCadastro extends StatefulWidget {
  const PromotoriaCadastro({super.key});

  @override
  State<PromotoriaCadastro> createState() => _PromotoriaCadastroState();
}

class _PromotoriaCadastroState extends State<PromotoriaCadastro> {
  final _nome = TextEditingController();
  late Promotoria promotoria = Promotoria(nome: _nome.text);
  final dao = PromotoriaDao();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Promotoria'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                TextFormField(
                  controller: _nome,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um nome';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              dao.salvar(promotoria);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso')),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
