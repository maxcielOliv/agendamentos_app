import 'package:agendamentos_app/database/models/dao/usuario_dao.dart';
import 'package:agendamentos_app/database/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Column(
      children: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('HomePage');
            },
            child: const Text('Entrar'),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
                final dao = UsuarioDao();
                final usuario = Usuario(usuario: 'wanderlan', senha: '1234');
                dao.delete(usuario);
            print('OK');
          },
        )
      ],
    );
  }
}
