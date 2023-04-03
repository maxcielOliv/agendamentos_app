import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var url =
      'https://img.elo7.com.br/product/zoom/42AF568/matriz-bordado-ministerio-publico-para-mppa-matriz-bordado-mppa.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imagens/teste.jpg',
                height: 250,
                width: 250,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bem Vindo',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'E-mail',
                          labelStyle: const TextStyle(fontSize: 20),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.red.shade300,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Senha',
                          labelStyle: const TextStyle(fontSize: 20),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.red.shade300,
                          )),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: 100.0,
                    child: RawMaterialButton(
                      fillColor: const Color(0xFF0069FE),
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () {
                        Navigator.of(context).pushNamed('HomePage');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
