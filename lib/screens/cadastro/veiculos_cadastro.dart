import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/database/models/veiculo.dart';
import 'package:flutter/material.dart';

class VeiculosCadastro extends StatefulWidget {
  const VeiculosCadastro({super.key});

  @override
  State<VeiculosCadastro> createState() => _VeiculosCadastroState();
}

class _VeiculosCadastroState extends State<VeiculosCadastro> {
  final _modelo = TextEditingController();
  final _placa = TextEditingController();
  final _motorista = TextEditingController();
  late Veiculo veiculo = Veiculo(
      placa: _placa.text, modelo: _modelo.text, motorista: _motorista.text);
  final dao = VeiculoDao();
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Veiculo'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: _focus,
                  controller: _modelo,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira Modelo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Modelo',
                    icon: Icon(Icons.today),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _placa,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira Placa';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Placa',
                    icon: Icon(Icons.place),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _motorista,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira motorista';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Motorista',
                    icon: Icon(Icons.airline_seat_recline_normal_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              dao.salvar(veiculo);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso')),
              );
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
