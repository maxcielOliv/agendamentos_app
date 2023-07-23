import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../database/models/dao/motorista_dao.dart';
import '../../database/models/motorista.dart';

class MotoristaCadastro extends StatefulWidget {
  const MotoristaCadastro({super.key, this.motorista});

  final Motorista? motorista;

  @override
  State<MotoristaCadastro> createState() => _MotoristaCadastroState();
}

class _MotoristaCadastroState extends State<MotoristaCadastro> {
  late final TextEditingController _nome;
  late final TextEditingController _fone;
  final _dao = MotoristaDao();
  final _formKey = GlobalKey<FormState>();
  late final _nomeO;
  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    _nomeO = widget.motorista?.nome;
    _nome = TextEditingController(text: widget.motorista?.nome);
    _fone = TextEditingController(text: widget.motorista?.fone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Motorista'),
        ),
        body: Container(
          padding: const EdgeInsets.all(14),
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
                  icon: Icon(Icons.person_rounded),
                ),
              ),
              TextFormField(
                controller: _fone,
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
            if (_formKey.currentState!.validate()) {
              final motorista = Motorista(
                  id: widget.motorista?.id,
                  criacao: widget.motorista?.criacao,
                  nome: _nome.text,
                  fone: _fone.text);
              if (_nomeO != _nome.text) {
                motorista.copyWith(_nome.text);
                if (await _dao.salvar(motorista)) {
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
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
