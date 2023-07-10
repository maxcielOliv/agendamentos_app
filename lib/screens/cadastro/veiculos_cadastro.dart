import 'package:agendamentos_app/database/models/dao/motorista_dao.dart';
import 'package:agendamentos_app/database/models/dao/veiculo_dao.dart';
import 'package:agendamentos_app/database/models/motorista.dart';
import 'package:agendamentos_app/database/models/veiculo.dart';
import 'package:flutter/material.dart';

class VeiculosCadastro extends StatefulWidget {
  const VeiculosCadastro({super.key, this.veiculo});

  final Veiculo? veiculo;

  @override
  State<VeiculosCadastro> createState() => _VeiculosCadastroState();
}

class _VeiculosCadastroState extends State<VeiculosCadastro> {
  final _marca = TextEditingController();
  final _modelo = TextEditingController();
  final _placa = TextEditingController();
  late Veiculo veiculo =
      Veiculo(marca: _marca.text, modelo: _modelo.text, placa: _placa.text);
  final daoMotorista = MotoristaDao();
  final daoVeiculo = VeiculoDao();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Veículo'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                TextFormField(
                    controller: _marca,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a marca/fabricante do veículo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Marca/Fabricante',
                      border: OutlineInputBorder(),
                      //icon: Icon(Icons.car_crash_rounded),
                    )),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _modelo,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um modelo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Modelo',
                    border: OutlineInputBorder(),
                    //icon: Icon(Icons.today),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _placa,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um número de placa';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Placa',
                    border: OutlineInputBorder(),
                    //icon: Icon(Icons.place),
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<Motorista>>(
                  stream: daoMotorista.getAllStream(),
                  builder: (context, snapshots) {
                    List<DropdownMenuItem<String>> motoristaItens = [];
                    if (!snapshots.hasData) {
                      const CircularProgressIndicator();
                    } else {
                      final motoristas = snapshots.data?.reversed.toList();
                      for (var motorista in motoristas!) {
                        motoristaItens.add(
                          DropdownMenuItem(
                            value: motorista.nome,
                            child: Text(motorista.nome.toString()),
                          ),
                        );
                      }
                    }
                    return SizedBox(
                      //width: 380,
                      child: DropdownButtonFormField<String>(
                        icon: const Icon(Icons.account_balance),
                        onSaved: (motorista) => veiculo.motorista = motorista,
                        isExpanded: true,
                        decoration: const InputDecoration(
                            labelText: 'Motorista',
                            border: OutlineInputBorder()),
                        hint: const Text('Motorista'),
                        items: motoristaItens,
                        onChanged: (usuarioValue) {},
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              daoVeiculo.salvar(veiculo);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cadastro realizado com sucesso')),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Icon(
            Icons.save,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
