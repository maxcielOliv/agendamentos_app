import 'package:flutter/material.dart';
import '../screens/cadastro/motorista_cadastro.dart';
import '../services/auth_service.dart';


class NivelButton extends StatelessWidget {
  const NivelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: ((context) {
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
    }));
  }
}
