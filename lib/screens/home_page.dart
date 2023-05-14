import 'package:agendamentos_app/screens/calendar/calendar2.dart';
import 'package:agendamentos_app/screens/view/change_password.dart';
import 'package:agendamentos_app/screens/view/motoristas_screen.dart';
import 'package:agendamentos_app/screens/view/promotoria_screen.dart';
import 'package:agendamentos_app/screens/view/usuarios_screen.dart';
import 'package:agendamentos_app/screens/view/veiculos_screen.dart';
import 'package:agendamentos_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  User? usuario;

  String nome = '';
  String email = '';

  @override
  void initState() {
    loadCurrentUser();
    admin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Agendamentos'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Olá, $nome'),
              accountEmail: Text(email),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.account_circle_rounded, size: 54),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Promotorias'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PromotoriaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_motorsports_outlined),
              title: const Text('Motoristas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MotoristaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.drive_eta),
              title: const Text('Veiculos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VeiculoScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_available_rounded),
              title: const Text('Agendamentos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.man_rounded),
              title: const Text('Usuários'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsuarioScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Alterar Senha'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePassword(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Sair'),
              onTap: () {
                AuthService().logout(context);
              },
            ),
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [Tela2()],
      //   ),
      // ),
    );
  }

  loadCurrentUser() async {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
  }

  Future<bool> admin() async {
    User? usuario = _firebaseAuth.currentUser;
    bool admin = false;
    if (usuario != null) {
      final docAdmin = await _db.collection('admins').doc(usuario.uid).get();
      if (docAdmin.exists) {
        admin = true;
      }
    }
    return true;
  }
}
