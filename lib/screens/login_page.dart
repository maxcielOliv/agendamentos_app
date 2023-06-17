import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/reset_password_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final senha = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final carregando = ValueNotifier<bool>(false);
    const separador = SizedBox(height: 10);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ListView(
            children: [
              Image.asset('assets/imagens/teste.jpg'),
              const Column(
                children: [
                  Text(
                    'PROMOTORIA DE JUSTIÇA DE ALTAMIRA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Agendamentos de Veículos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              separador,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    separador,
                    TextFormField(
                      controller: senha,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              // separador,
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    'Recuperar Senha',
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              AnimatedBuilder(
                animation: carregando,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: carregando.value
                        ? null
                        : () async {
                            carregando.value = true;
                            try {
                              await AuthService().login(email.text, senha.text);
                              if (context.mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            } on AuthException catch (e) {
                              carregando.value = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.mensagem),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: carregando.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'ENTRAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
