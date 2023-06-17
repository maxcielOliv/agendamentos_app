import 'package:flutter/material.dart';
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
  final _dao = MotoristaDao();
  final _formKey = GlobalKey<FormState>();
  late final _nomeO;

  @override
  void initState() {
    _nomeO = widget.motorista?.nome;
    _nome = TextEditingController(text: widget.motorista?.nome);
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
          padding: const EdgeInsets.all(10),
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
                cpf: widget.motorista?.cpf,
                matricula: widget.motorista?.matricula,
              );
              if (_nomeO != _nome.text) {
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
