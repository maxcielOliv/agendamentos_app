import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/dao/usuario_dao.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/helpers/validators.dart';
import 'package:flutter/material.dart';

class UsuarioEditor extends StatelessWidget {
  final Usuario? usuarioValor;
  const UsuarioEditor({super.key, this.usuarioValor});

  @override
  Widget build(BuildContext context) {
    final nome = TextEditingController(text: usuarioValor?.nome);
    final email = TextEditingController(text: usuarioValor?.email);
    //final senha = TextEditingController(text: usuarioValor?.senha);
    final formKey = GlobalKey<FormState>();
    late Usuario user =
        Usuario(id: usuarioValor?.id, nome: nome.text, email: email.text, senha: '***');
    final daoPromotoria = PromotoriaDao();
    final daoUsuario = UsuarioDao();

    List<String> itens = ['Administrador', 'Agendador', 'Comum'];
    
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Usuário'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                TextFormField(
                  controller: nome,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20
                    )
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (nome) {
                    if (nome!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (nome.trim().split(' ').length <= 1) {
                      return 'Preencha o nome completo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  enabled: false,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20
                    )
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!emailValid(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
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
                          )
                        );
                      }
                    }
                    return SizedBox(
                      child: DropdownButtonFormField<String>(
                        value: usuarioValor?.lotacao,
                        icon: const Icon(Icons.account_balance),
                        onSaved: (lotacao) => user.lotacao = lotacao,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Lotação',
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text('Lotação'),
                        items: promotoriaItens,
                        onChanged: (usuarioValue) {},
                      )
                    );
                  }
                ),
                const SizedBox(height: 10),
                TextFormField(
                  enabled: false,
                  //controller: senha,
                  decoration: const InputDecoration(
                    labelText: 'Digite a Senha Padrão',
                    border: OutlineInputBorder(),                    
                  )
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    value: usuarioValor?.nivel,
                    icon: const Icon(Icons.person_2_rounded),
                    isExpanded: true,
                    onSaved: (nivel) => user.nivel = nivel,
                    decoration: const InputDecoration(
                      labelText: 'Nível',
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Nível'),
                    items: itens.map((itens) => DropdownMenuItem<String>(value: itens, child: Text(itens))).toList(),
                    onChanged: (usuarioValue) {},                        
                  ),
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
              daoUsuario.salvar(user);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                      'Cadastro ${user.id == null ? 'criado' : 'atualizado'} com sucesso'),
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
