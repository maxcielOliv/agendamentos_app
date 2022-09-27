import 'package:agendamentos_app/screens/home_page.dart';
import 'package:agendamentos_app/screens/login_screen.dart';
import 'package:agendamentos_app/screens/motoristas_screen.dart';
import 'package:agendamentos_app/screens/veiculos_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        'HomePage': (context) => const HomePage(),
        'Veiculos': (context) => const VeiculoScreen(),
        'Motoristas': (context) => const MotoristaScreen()
      },
    );
  }
}
