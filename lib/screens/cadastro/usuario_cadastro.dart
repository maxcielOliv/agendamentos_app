import 'package:agendamentos_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool carregando = false;

  sigUp() async {
    setState(() => carregando = true);
    try {
      await AuthService().sigUp(email.text, senha.text, context);
    } on AuthException catch (e) {
      setState(() => carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.mensagem),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Usuários'),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: senha,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                style: const TextStyle(fontSize: 20),
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
                                'Cadastre-se',
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
                      // if (_formKey.currentState!.validate()) {
                      sigUp();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //         content: Text('Cadastro realizado com sucesso')),
                      //   );
                      // }
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
}
