import 'package:flutter/material.dart';

class Cores extends StatelessWidget {
  const Cores({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> cores = [];
    cores.add(const Color(0xFF0F8644));
    cores.add(const Color(0xFFD20100));
    cores.add(const Color(0xFFFC571D));
    cores.add(const Color(0xff3d4fb5));
    final nomes = <String>[];
    nomes.add('Verde');
    nomes.add('Vermelho');
    nomes.add('Laranja');
    nomes.add('Azul');
    final Color selecionaCor = cores[0];
    final trocar = ValueNotifier<int>(0);
    return AnimatedBuilder(
        animation: trocar,
        builder: (context, snapshot) {
          return AlertDialog(
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: cores.length - 1,
                itemBuilder: (context, int index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(nomes[index].toString()),
                    leading: Icon(
                      index == selecionaCor ? Icons.lens : Icons.trip_origin,
                      color: cores[index],
                    ),
                    onTap: () {
                      trocar.value = selecionaCor.value;
                      Navigator.of(context).pop();
                      print(selecionaCor.value);
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
