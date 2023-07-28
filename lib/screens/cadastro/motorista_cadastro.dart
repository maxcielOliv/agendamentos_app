import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../database/models/dao/motorista_dao.dart';
import '../../database/models/motorista.dart';

class MotoristaCadastro extends StatelessWidget {
  final Motorista? motoristaValor;
  const MotoristaCadastro({super.key, this.motoristaValor});

  @override
  Widget build(BuildContext context) {
    final nome = TextEditingController(text: motoristaValor?.nome);
    final fone = TextEditingController(text: motoristaValor?.fone);
    final dao = MotoristaDao();
    final formKey = GlobalKey<FormState>();
    late Motorista motorista =
        Motorista(id: motoristaValor?.id, nome: nome.text, fone: fone.text);
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Motorista'),
        ),
        body: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              TextFormField(
                controller: nome,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um nome';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.person_rounded),
                ),
              ),
              TextFormField(
                controller: fone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um telefone';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  icon: Icon(Icons.person_rounded),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (await dao.salvar(motorista)) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                          'Cadastro ${motorista.id == null ? 'criado' : 'atualizado'} com sucesso'),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              }
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
