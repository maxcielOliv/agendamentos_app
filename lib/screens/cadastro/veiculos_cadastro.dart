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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: _modelo,
                // showCursor: true,
                // readOnly: true,
                keyboardType: TextInputType.name,
                validator: (value) {},
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
                // showCursor: true,
                // readOnly: true,
                keyboardType: TextInputType.name,
                validator: (value) {},
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
                // showCursor: true,
                // readOnly: true,
                keyboardType: TextInputType.name,
                validator: (value) {},
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
          dao.salvar(veiculo);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
