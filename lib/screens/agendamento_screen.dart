import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgendamentoScreen extends StatelessWidget {
  const AgendamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('AgendamentosCadastro');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('agendamento').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Erro ao carregar!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          if (data != null) {
            return ListView.separated(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data.docs[index]['local']),
                  subtitle: const Text('data'),
                );
              },
              separatorBuilder: ((context, index) => const Divider(
                    thickness: 1,
                  )),
            );
          }
          return const Text('Sem dados');
        },
      ),
    );
  }
}
