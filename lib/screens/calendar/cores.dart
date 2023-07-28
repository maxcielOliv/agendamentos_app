import 'package:flutter/material.dart';

class Cores extends StatelessWidget {
  const Cores({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> cores = [];
    cores.add(const Color(0xFF0F8644));
    cores.add(const Color(0xFF8B1FA9));
    cores.add(const Color(0xFFD20100));
    cores.add(const Color(0xFFFC571D));
    cores.add(const Color(0xFF85461E));
    cores.add(const Color(0xFFFF00FF));
    cores.add(const Color(0xFF3D4FB5));
    cores.add(const Color(0xFFE47C73));
    cores.add(const Color(0xFF636363));
    final Color selecionaCor = cores[0];
    final trocar = ValueNotifier<bool>(false);
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: cores.length - 1,
          itemBuilder: (context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Icon(
                index == selecionaCor ? Icons.lens : Icons.trip_origin,
                color: cores[index],
              ),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
