import 'package:agendamentos_app/database/models/dao/promotor_dao.dart';
import 'package:agendamentos_app/database/models/promotor.dart';
import 'package:flutter/material.dart';

class PromotorCadastro extends StatefulWidget {
  const PromotorCadastro({super.key});

  @override
  State<PromotorCadastro> createState() => _PromotorCadastroState();
}

class _PromotorCadastroState extends State<PromotorCadastro> {
  final _nome = TextEditingController();
  final _matricula = TextEditingController();
  late Promotor promotor =
      Promotor(nome: _nome.text, matricula: _matricula.text);
  final dao = PromotorDao();
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

  @override
  void dispose() {
    _nome.dispose();
    _matricula.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Promotor'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: _focus,
                  controller: _nome,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira Nome';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    icon: Icon(Icons.location_city_rounded),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _matricula,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira Matricula';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Matricula',
                    icon: Icon(Icons.location_city_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              dao.salvar(promotor);
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
