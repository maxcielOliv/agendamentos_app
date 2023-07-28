import 'package:agendamentos_app/screens/view/auth_page.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/reset_password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final senha = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final carregando = ValueNotifier<bool>(false);
    final showPass = ValueNotifier<bool>(false);
    const separador = SizedBox(height: 10);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ListView(
            children: [
              Image.asset('assets/imagens/teste2.png', height: 160, width: 160),
              const SizedBox(height: 60),
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
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.primary,
                        labelText: 'E-mail',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe um E-mail';
                        }
                        return null;
                      },
                    ),
                    separador,
                    AnimatedBuilder(
                      animation: showPass,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: senha,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: const OutlineInputBorder(),
                            suffixIcon: GestureDetector(
                              child: Icon(
                                  showPass.value == false
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.blue),
                              onTap: () {
                                showPass.value = !showPass.value;
                              },
                            ),
                          ),
                          obscureText: showPass.value == false ? true : false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe uma senha';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    'Esqueceu sua Senha?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
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
                                    builder: (context) => const AuthPage(),
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
