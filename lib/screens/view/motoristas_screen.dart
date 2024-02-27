import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:agendamentos_app/screens/cadastro/motorista_cadastro.dart';
import 'package:agendamentos_app/services/auth_service.dart';
import 'package:flutter/material.dart';

//Tela de motorista, mostra todos os motoristas cadastrados
class MotoristaScreen extends StatelessWidget {
  final Motorista? motorista;
  const MotoristaScreen({super.key, this.motorista});

  @override
  Widget build(BuildContext context) {
    final dao = MotoristaDao();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motoristas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          Builder(builder: ((context) {
            if (AuthService().adminEnabled) {
              return IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MotoristaCadastro(),
                      ));
                },
              );
            }
            return Container();
          }))
        ],
      ),
      body: StreamBuilder<List<Motorista>>(
        stream: dao.getAllStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          final lista = snapshot.data ?? [];
          return ListView.separated(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final motorista = lista[index];
              if (AuthService().adminEnabled) {
                return ListTile(
                    onTap: () {
                      Navigator.push<Motorista>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MotoristaCadastro(
                            motoristaValor: motorista,
                          ),
                        ),
                      );
                    },
                    title: Text(motorista.nome),
                    subtitle: Text('${motorista.fone}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_rounded),
                      onPressed: () {
                        dao.deletar(motorista);
                      },
                    ));
              }
              return ListTile(
                title: Text(motorista.nome),
                subtitle: Text('${motorista.fone}'),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 0,
            ),
          );
        },
      ),
    );
  }
}
