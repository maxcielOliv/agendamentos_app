import 'package:agendamentos_app/database/models/user_manager.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:agendamentos_app/screens/home_page.dart';
import 'package:agendamentos_app/screens/view/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //bool isLogin = true;
  bool carregando = false;

  // @override
  // void initState() {
  //   super.initState();
  //   setFormAction(true);
  // }

  // setFormAction(bool acao) {
  //   setState(() {
  //     isLogin = acao;
  //   });
  // }

  /*login() async {
    setState(() => carregando = true);
    try {
      await AuthService().login(Usuario(email: email.text, senha: senha.text), context);
    } on AuthException catch (e) {
      setState(() => carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.mensagem),
        ),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 40,
              right: 40,
            ),
            color: Colors.white,
            child: Consumer<UserManager>(
              builder: (context, userManager, __) {
                return ListView(
                  children: [
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: Image.asset('assets/imagens/teste.jpg'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'PROMOTORIA DE JUSTIÇA DE ALTAMIRA',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Agendamentos de Veículos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: email,
                      enabled: !userManager.loading,
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
                      enabled: !userManager.loading,
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
                    Container(
                      height: 30,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text('Recuperar Senha',
                            textAlign: TextAlign.right),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordPage(),
                            ),
                          );
                        },
                      ),
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
                                      'Login',
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
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  //if (isLogin) {
                                  //login();
                                  userManager.signIn(
                                      user: Usuario(
                                          email: email.text, senha: senha.text),
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      },
                                      onSuccess: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      });
                                  //}
                                },
                        ),
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
