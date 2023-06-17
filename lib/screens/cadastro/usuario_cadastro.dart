import 'package:agendamentos_app/services/user_manager.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioCadastro extends StatefulWidget {
  const UsuarioCadastro({super.key});

  @override
  State<UsuarioCadastro> createState() => _UsuarioCadastroState();
}

class _UsuarioCadastroState extends State<UsuarioCadastro> {
  final _formKey = GlobalKey<FormState>();
  final Usuario usuario = Usuario();
  bool carregando = false;

  final Usuario user = Usuario();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Usuários'),
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
                //controller: nome,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Nome Completo',
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
                onSaved: (nome) => user.nome = nome,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                //controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                style: const TextStyle(fontSize: 20),
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (!emailValid(email)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                onSaved: (email) => user.email = email,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                //controller: senha,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Digite uma Senha',
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
                validator: (senha) {
                  if (senha!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (senha.length < 6) {
                    return 'Sua senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
                onSaved: (senha) => user.senha = senha,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                //controller: senha,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Repita sua Senha',
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
                validator: (senha) {
                  if (senha!.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (senha.length < 6) {
                    return 'Sua senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
                onSaved: (senha) => user.confirmaSenha = senha,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 40),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 1],
                        colors: [Colors.red, Colors.blue]),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: SizedBox.expand(
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 28,
                                width: 28,
                                child: Icon(
                                  Icons.login_rounded,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              )
                            ],
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Cadastro realizado com sucesso')),
                        //   );
                        //Navigator.of(context).pop();
                        if (user.senha != user.confirmaSenha) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Senhas não coincidem'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        context.read<UserManager>().signUp(
                              user: user,
                              onFail: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSuccess: () {},
                            );
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
