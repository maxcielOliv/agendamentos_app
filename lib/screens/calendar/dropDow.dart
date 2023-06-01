import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DropdownButton com Firebase',
    );
  }
}

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  List<dynamic> _categories = [];
  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('motorista').get();

    final List<DocumentSnapshot> documents = result.docs;
    print(result);
    setState(() {
      _categories = documents.map((doc) => doc['nome']).toList();
      print(_categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    String _selectedCategory = _categories.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: _selectedCategory,
              items: _categories.map(
                (category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(
                  () {
                    _selectedCategory = value.toString();
                  },
                );
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              'Selecione o motorista: $_selectedCategory',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
