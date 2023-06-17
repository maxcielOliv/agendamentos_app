import 'package:agendamentos_app/services/user_manager.dart';
import 'package:agendamentos_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agendamentos App',
        theme: ThemeData(
            //primarySwatch: Colors.blue,
            // primaryColor: Colors.black,
            // primaryColorDark: Colors.black,
            // primaryColorLight: Colors.white,
            ),
        home: const LoginPage(),
      ),
    );
  }
}
