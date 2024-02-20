import 'package:flutter/material.dart';

import '../../database/models/dao/motorista_dao.dart';
import '../../database/models/dao/veiculo_dao.dart';
import '../../database/models/motorista.dart';
import '../../database/models/veiculo.dart';

class VeiculosCadastro extends StatelessWidget {
  final Veiculo? veiculoValor;
  const VeiculosCadastro({super.key, this.veiculoValor});

  final separador = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final marca = TextEditingController(text: veiculoValor?.marca);
    final modelo = TextEditingController(text: veiculoValor?.modelo);
    final placa = TextEditingController(text: veiculoValor?.placa);
    final motoristaControler =
        TextEditingController(text: veiculoValor?.motorista);
    final daoMotorista = MotoristaDao();
    final daoVeiculo = VeiculoDao();
    final formKey = GlobalKey<FormState>();
    late Veiculo veiculo = Veiculo(
        id: veiculoValor?.id,
        marca: marca.text,
        modelo: modelo.text,
        placa: placa.text,
        motorista: motoristaControler.text);
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Veiculos'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                TextFormField(
                  controller: marca,
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
                  ),
                ),
                separador,
                TextFormField(
                  controller: modelo,
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
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: placa,
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
                  ),
                ),
                separador,
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
                            child: Text(motorista.nome),
                          ),
                        );
                      }
                    }
                    return SizedBox(
                      child: DropdownButtonFormField(
                        value: veiculoValor?.motorista,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text('Motorista'),
                        items: motoristaItens,
                        onChanged: (String? motoristaValue) {
                          motoristaControler.text = motoristaValue!;
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              daoVeiculo.salvar(veiculo);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                      'Cadastro ${veiculo.id == null ? 'criado' : 'atualizado'} com sucesso'),
                ),
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
