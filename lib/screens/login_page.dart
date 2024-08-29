import 'package:agendamentos_app/screens/view/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/auth_service.dart';
import '../services/reset_password_page.dart';
import '../env.dart';

//página de login do aplicativo
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final senha = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final carregando = ValueNotifier<bool>(false);
    final isChecked = ValueNotifier<bool>(false);
    final showPass = ValueNotifier<bool>(false);
    const separador = SizedBox(height: 20);

    final emailBox = Hive.box('email');

    void saveEmail() {
      if (isChecked.value) {
        emailBox.put('email', email.text);
      } else {
        emailBox.put('email', '');
        isChecked.value = false;
      }
    }

    void getData() {
      if (emailBox.get('email') != null) {
        email.text = emailBox.get('email');
        isChecked.value = true;
        //print(emailBox.values);
      }
    }

    getData();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ListView(
            children: [
              //Image.asset('assets/imagens/teste2.png', height: 160, width: 160),
              const Icon(Icons.account_circle_rounded,
                  size: 120, color: Color.fromARGB(255, 237, 70, 48)),
              separador,
              const Column(
                children: [
                  Text(
                    'PromotoCar Agendamentos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bem-vindo(a)!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
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
              separador,
              Align(
                alignment: Alignment.center,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: isChecked,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        child: Icon(
                          isChecked.value == false
                              ? Icons.check_box_outline_blank_rounded
                              : Icons.check_box_rounded,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          isChecked.value = !isChecked.value;
                          //print(isChecked.value);
                        },
                      );
                    },
                  ),
                  Text(
                    'Manter E-mail salvo',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
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
                                saveEmail();
                                //getData();
                              }
                            } on AuthException catch (e) {
                              carregando.value = false;
                              // ignore: use_build_context_synchronously
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
