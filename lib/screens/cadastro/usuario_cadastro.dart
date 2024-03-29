import 'package:agendamentos_app/database/models/dao/promotoria_dao.dart';
import 'package:agendamentos_app/database/models/promotoria.dart';
import 'package:agendamentos_app/services/auth_service.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/helpers/validators.dart';
import 'package:flutter/material.dart';

class UsuarioCadastro extends StatefulWidget {
  const UsuarioCadastro({super.key});

  @override
  State<UsuarioCadastro> createState() => _UsuarioCadastroState();
}

class _UsuarioCadastroState extends State<UsuarioCadastro> {
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Usuario user = Usuario(nome: _nome.text, email: _email.text, senha: _senha.text);
  final daoPromotoria = PromotoriaDao();
  bool _showPass = false;
  bool carregando = false;

  List<String> itens = ['Administrador', 'Agendador', 'Comum'];
  String? selectedItem = 'Administrador';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Usuários'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: 60,
            left: 40,
            right: 40,
          ),
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _nome,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
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
              const SizedBox(
                height: 10,
              ),
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
                    width: 280,
                    child: DropdownButtonFormField<String>(
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
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _senha,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Digite a Senha Padrão',
                  border: const OutlineInputBorder(),
                  labelStyle: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                  suffixIcon: GestureDetector(
                    child: Icon(_showPass == false ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
                    onTap: () {
                      setState(() {
                        _showPass = !_showPass;
                      });
                    }
                  )
                ),
                style: const TextStyle(fontSize: 20),
                obscureText: _showPass == false ? true : false,
                validator: (senha) {
                  if (senha!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (senha.length < 6) {
                    return 'Sua senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.person_2_rounded),
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Nível',
                    border: OutlineInputBorder()
                  ),
                  hint: const Text('Nível'),
                  onSaved: (nivel) => user.nivel = nivel,
                  value: selectedItem,
                  items: itens
                      .map((itens) => DropdownMenuItem<String>(
                        value: itens,
                        child: Text(itens),
                      ))
                      .toList(),
                  onChanged: (itens) => setState(() {
                    selectedItem = itens;
                  }),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [Colors.red, Colors.blue]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (carregando)
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]
                          : [
                              const Text(
                                'Cadastrar Usuário',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        await AuthService().signUp(user: user);
                          final nivel = user.nivel;
                          final userId = user.id;
                          user.saveNivel(userId!, user.nome!, nivel!);
                          print('$nivel | Id: $userId');

                        /*if (user.nivel == 'Agendador') {
                          final userId = user.id;
                          user.saveNivelAgend(userId!, user.nome!);
                          print('Agendador | Id: $userId');
                        }*/
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Cadastro realizado com sucesso')),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /*cadastrar() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.text, password: senha.text);
      dao.salvar(usuario);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crie uma senha mais forte'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print(e.code);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este e-mail já foi cadastrado'),
          ),
        );
      }
    }
  }*/
}
