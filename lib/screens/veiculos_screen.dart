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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: TextField(
          focusNode: _focus,
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Pesquisar',
          ),
          onChanged: (value) {
            if (value.length >= 3) {
              print(_controller);
              setState(() {});
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel_rounded),
            onPressed: () {
              if (_controller.text.isEmpty) {
                Navigator.pop(context);
              } else {
                _controller.text = '';
                _focus.requestFocus();
              }
            },
          ),
        ],
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
            return ListView.separated(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data.docs[index]['modelo']),
                  subtitle: Text(data.docs[index]['placa']),
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
