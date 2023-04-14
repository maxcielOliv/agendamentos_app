import 'package:agendamentos_app/screens/agendamento_screen.dart';
import 'package:agendamentos_app/screens/motoristas_screen.dart';
import 'package:agendamentos_app/screens/usuarios_screens.dart';
import 'package:agendamentos_app/screens/veiculos_screen.dart';
import 'package:agendamentos_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Agendamentos'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Agendamentos'),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {},
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
                    builder: (context) => const AgendamentoScreen(),
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
              onTap: () {
                AuthService().logout(context);
              },
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('veiculo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro ao carregar!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          if (data != null) {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Veiculos'),
                          subtitle: Text(data.docs[0]['motorista']),
                        ),
                        ListTile(
                          title: Text(data.docs[0]['modelo']),
                          subtitle: Text(data.docs[0]['placa']),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('Agendamentos');
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Veiculos'),
                          subtitle: Text(data.docs[1]['motorista']),
                        ),
                        ListTile(
                          title: Text(data.docs[1]['modelo']),
                          subtitle: Text(data.docs[1]['placa']),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('Agendamentos');
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Veiculos'),
                          subtitle: Text(data.docs[2]['motorista']),
                        ),
                        ListTile(
                          title: Text(data.docs[2]['modelo']),
                          subtitle: Text(data.docs[2]['placa']),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('Agendamentos');
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Text('Sem dados');
        },
      ),
    );
  }
}
