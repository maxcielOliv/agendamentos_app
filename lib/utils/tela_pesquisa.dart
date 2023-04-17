import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/database/models/veiculo.dart';
import 'package:agendamentos_app/screens/cadastro/veiculos_cadastro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VeiculoScreen extends StatefulWidget {
  const VeiculoScreen({super.key});

  @override
  State<VeiculoScreen> createState() => _VeiculoScreenState();
}

class _VeiculoScreenState extends State<VeiculoScreen> {
  final _db = FirebaseFirestore.instance;
  final _controller = TextEditingController();
  final _focus = FocusNode();
  final dao = VeiculoDao();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        // title: TextField(
        //   focusNode: _focus,
        //   controller: _controller,
        //   autofocus: true,
        //   decoration: const InputDecoration(
        //     border: OutlineInputBorder(),
        //     hintText: 'Pesquisar',
        //   ),
        //   onChanged: (value) {
        //     if (value.length >= 3) {
        //       print(value);
        //       setState(() {});
        //     }
        //   },
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VeiculosCadastro(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Veiculo>>(
        future: dao.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          final lista = snapshot.data!;
          if (lista.isEmpty && _controller.text.length >= 3) {
            return const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Nenhum resultado!',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final veiculo = lista[index];
              return ListTile(
                title: Text(veiculo.modelo),
                subtitle: Text(veiculo.placa),
                // onTap: () {
                //   Navigator.pop(context, alimento);
                // },
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 0,
            ),
          );
        },
      ),
      // floatingActionButton: ElevatedButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const Formulario(),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
