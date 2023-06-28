import 'package:agendamentos_app/utils/temas/dark_theme.dart';
import 'package:agendamentos_app/utils/temas/light_theme.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamentos App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LoginPage(),
    );
  }
}
