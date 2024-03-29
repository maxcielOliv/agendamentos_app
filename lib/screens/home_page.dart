import 'package:agendamentos_app/screens/calendar/mult_calendarios.dart';
import 'package:agendamentos_app/screens/view/agendamento_screen.dart';
import 'package:agendamentos_app/screens/view/configuracoes_screen.dart';
import 'package:agendamentos_app/screens/view/promotor_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'calendar/calendario.dart';
import 'login_page.dart';
import 'view/motoristas_screen.dart';
import 'view/promotoria_screen.dart';
import 'view/usuarios_screen.dart';
import 'view/veiculos_screen.dart';

//Página principal do aplicativo
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              await AuthService().logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: AnimatedBuilder(
                  animation: AuthService(),
                  builder: (context, child) {
                    if (AuthService().user != null) {
                      return Text(
                        'Olá, ' '${AuthService().user!.nome?.toUpperCase()}',
                        style: TextStyle(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary),
                      );
                    }
                    return Text(
                      'nome',
                      style: TextStyle(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary),
                    );
                  }),
              accountEmail: AnimatedBuilder(
                animation: AuthService(),
                builder: (context, child) {
                  if (AuthService().user != null) {
                    return Text(AuthService().user!.email!);
                  }
                  return const Text('Email');
                },
              ),
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
            /*ListTile(
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
            ),*/
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
            /*ListTile(
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
            ),*/
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
            /*ListTile(
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
            ),*/
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
            Builder(
              builder: (context) {
                if (AuthService().adminEnabled) {
                  return Column(
                    children: [
                      const Divider(
                        height: 10.0,
                        color: Colors.blue,
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
                        leading: const Icon(Icons.man_rounded),
                        title: const Text('Usuários'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UsuarioScreen(),
                              ));
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
                    ],
                  );
                }
                return Container();
              },
            )
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
                  AnimatedBuilder(
                      animation: AuthService(),
                      builder: (context, child) {
                        if (AuthService().user != null) {
                          return Text(
                            'Bem-Vindo, ${AuthService().user!.nome?.toUpperCase()}!',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          );
                        }
                        return const Text(
                          'Bem-Vindo !',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        );
                      }),
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
                              Icons.car_rental_rounded,
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
                  const SizedBox(height: 10),
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
                              'Visualizar Calendário',
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
                          builder: (context) => const AgendamentoCadastro(),
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
