import 'package:agendamentos_app/database/models/dao/promotor_dao.dart';
import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/promotor.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:flutter/material.dart';

class PromotorCadastro extends StatefulWidget {
  const PromotorCadastro({super.key});

  @override
  State<PromotorCadastro> createState() => _PromotorCadastroState();
}

class _PromotorCadastroState extends State<PromotorCadastro> {
  final _formKey = GlobalKey<FormState>();
  final Promotor promotor = Promotor();
  final daoPromotor = PromotorDao();
  final daoPromotoria = PromotoriaDao();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Promotores'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                TextFormField(
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
                  ),
                  onSaved: (nome) => promotor.nome = nome,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um número de matrícula';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Matrícula',
                    border: OutlineInputBorder(),
                    //icon: Icon(Icons.contact_phone_rounded),
                  ),
                  onSaved: (matricula) => promotor.matricula = matricula,
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<Promotoria>>(
                  stream: daoPromotoria.getAllStream(),
                  builder: (context, snapshots) {
                    List<DropdownMenuItem<String>> promotoriaItens = [];
                    if (!snapshots.hasData) {
                      const CircularProgressIndicator();
                    } else {
                      final promotorias = snapshots.data?.reversed.toList();
                      for (var promotoria in promotorias!) {
                        promotoriaItens.add(
                          DropdownMenuItem(
                            value: promotoria.nome,
                            child: Text(
                              promotoria.nome.toString(),
                            ),
                          ),
                        );
                      }
                    }
                    return SizedBox(
                      //width: 380,
                      child: DropdownButtonFormField<String>(
                        icon: const Icon(Icons.account_balance),
                        onSaved: (lotacao) => promotor.lotacao = lotacao,
                        isExpanded: true,
                        decoration: const InputDecoration(
                            labelText: 'Lotação', border: OutlineInputBorder()),
                        hint: const Text('Lotação'),
                        items: promotoriaItens,
                        onChanged: (usuarioValue) {},
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              daoPromotor.salvar(promotor);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso')),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Icon(
            Icons.save,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
