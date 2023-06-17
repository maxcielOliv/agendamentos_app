import 'package:agendamentos_app/screens/view/promotor_screen.dart';
import 'package:agendamentos_app/services/user_manager.dart';
import 'package:agendamentos_app/screens/calendar/calendar2.dart';
import 'package:agendamentos_app/services/change_password.dart';
import 'package:agendamentos_app/screens/view/motoristas_screen.dart';
import 'package:agendamentos_app/screens/view/promotoria_screen.dart';
import 'package:agendamentos_app/screens/view/usuarios_screen.dart';
import 'package:agendamentos_app/screens/view/veiculos_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _usuario = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Agendamentos'),
      ),
      drawer: Drawer(
        child: Consumer<UserManager>(
          builder: (context, userManager, __) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    'Olá, ${_usuario?.displayName ?? 'usuário'}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  accountEmail: Text(
                    _usuario?.email ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.account_circle_rounded, size: 54),
                  ),
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
                    userManager.signOut(context);
                  },
                ),
                Consumer<UserManager>(
                  builder: (context, userManager, __) {
                    if (userManager.adminEnabled) {
                      return Column(
                        children: [
                          const Divider(),
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
                            leading: const Icon(Icons.home_outlined),
                            title: const Text('Promotorias'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PromotoriaScreen(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.home_outlined),
                            title: const Text('Promotor'),
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
