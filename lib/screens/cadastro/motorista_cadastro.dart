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
  late final TextEditingController _celular;
  final _dao = MotoristaDao();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _nome = TextEditingController(text: widget.motorista?.nome);
    _celular = TextEditingController(text: widget.motorista?.fone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Motorista'),
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _celular,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um número de celular';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Celular',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.contact_phone_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final motorista = Motorista(
                id: widget.motorista?.id,
                criacao: widget.motorista?.criacao,
                nome: _nome.text,
                fone: _celular.text,
              );
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
          },
          child: const Icon(Icons.save, color: Colors.blue),
        ),
      ),
    );
  }
}
