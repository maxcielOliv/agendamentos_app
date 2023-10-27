import 'package:flutter/material.dart';
import '../../database/models/dao/promotoria_dao.dart';
import '../../database/models/promotoria.dart';

class PromotoriaCadastro extends StatelessWidget {
  final Promotoria? promotoriaValor;
  const PromotoriaCadastro({super.key, this.promotoriaValor});

  @override
  Widget build(BuildContext context) {
    final nome = TextEditingController(text: promotoriaValor?.nome);
    late Promotoria promotoria =
        Promotoria(id: promotoriaValor?.id, nome: nome.text);
    final daoPromotoria = PromotoriaDao();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
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
                    icon: Icon(Icons.account_balance),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              daoPromotoria.salvar(promotoria);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                      'Cadastro ${promotoria.id == null ? 'criado' : 'atualizado'} com sucesso'),
                ),
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
