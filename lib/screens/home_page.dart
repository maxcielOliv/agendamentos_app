import 'package:agendamentos_app/screens/calendar/mult_calendarios.dart';
import 'package:agendamentos_app/screens/view/agendamento_screen.dart';
import 'package:agendamentos_app/screens/view/promotor_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'view/configuraçoes_screen.dart';
import 'view/motoristas_screen.dart';
import 'view/promotoria_screen.dart';
import 'view/usuarios_screen.dart';
import 'view/veiculos_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('App Agendamentos'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Olá, ' '${AuthService().user.nome?.toUpperCase()}',
                style: TextStyle(
                    backgroundColor: Theme.of(context).colorScheme.secondary),
              ),
              accountEmail: Text(AuthService().user.email!),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.account_circle_rounded, size: 54),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.event_available_rounded),
              title: const Text('Agendamentos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgendamentoScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.drive_eta),
              title: const Text('Veículos'),
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
              leading: const Icon(Icons.person_2_rounded),
              title: const Text('Promotores de Justiça'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PromotorScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Configuracoes(),
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
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Sair'),
              onTap: () async {
                await AuthService().logout();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ListView(
            children: [
              Column(
                children: [
                  Text(
                    'Bem-Vindo, '
                    '${AuthService().user.nome?.toUpperCase()}!',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Text('Escolha uma Tarefa',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 30),
                  InkWell(
                    child: Card(
                      color: Colors.red.shade400,
                      elevation: 50.0,
                      borderOnForeground: true,
                      shadowColor: Colors.blue,
                      child: Container(
                        height: 100,
                        width: 200,
                        padding: const EdgeInsets.all(20),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              size: 28,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Agendar uma Missão',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MultCalendarios(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
