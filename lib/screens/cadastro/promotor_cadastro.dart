import 'package:flutter/material.dart';

import '../../database/models/dao/promotor_dao.dart';
import '../../database/models/dao/promotoria_dao.dart';
import '../../database/models/promotor.dart';
import '../../database/models/promotoria.dart';

class PromotorCadastro extends StatelessWidget {
  final Promotor? promotorValor;
  const PromotorCadastro({super.key, this.promotorValor});

  @override
  Widget build(BuildContext context) {
    final nome = TextEditingController(text: promotorValor?.nome);
    final matricula = TextEditingController(text: promotorValor?.matricula);
    final formKey = GlobalKey<FormState>();
    final daoPromotor = PromotorDao();
    final daoPromotoria = PromotoriaDao();
    late Promotor promotor =
        Promotor(id: promotorValor?.id, nome: nome.text, matricula: matricula.text);

    return Form(
      key: formKey,
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
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: matricula,
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
                      hintText: '999.9999'),
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
                            child: Text(promotoria.nome.toString()),
                          ),
                        );
                      }
                    }
                    return SizedBox(
                      child: DropdownButtonFormField<String>(
                        value: promotorValor?.lotacao,
                        icon: const Icon(Icons.account_balance),
                        onSaved: (lotacao) => promotor.lotacao = lotacao,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Lotação',
                          border: OutlineInputBorder(),
                        ),
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
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();
              daoPromotor.salvar(promotor);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                      'Cadastro ${promotor.id == null ? 'criado' : 'atualizado'} com sucesso'),
                ),
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
