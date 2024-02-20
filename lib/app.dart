import 'package:agendamentos_app/screens/view/agendamento_screen.dart';
import 'package:agendamentos_app/screens/view/auth_page.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamentos App',
      debugShowCheckedModeBanner: false,
      //theme: temaClaro,
      //darkTheme: temaEscuro,
      //supportedLocales: const [Locale('pt', 'BR')],
      home: const AuthPage(),
      navigatorKey: navigatorKey,
      routes: {'/agendamento_screen': (context) => const AgendamentoScreen()},
    );
  }
}
