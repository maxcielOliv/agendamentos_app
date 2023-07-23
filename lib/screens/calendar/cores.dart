import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ColorPickerState();
  }
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    //_colorCollection.add(const Color(0xFFE47C73));
    //.add(const Color(0xFF636363));
    _colorNames.add('Verde');
    _colorNames.add('Roxo');
    _colorNames.add('Vermelho');
    _colorNames.add('Laranja');
    _colorNames.add('Marrom');
    _colorNames.add('Magenta');
    _colorNames.add('Azul');
    //_colorNames.add('Peach');
    //_colorNames.add('Gray');
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: _colorCollection.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Icon(
                  index == _selectedColorIndex ? Icons.lens : Icons.trip_origin,
                  color: _colorCollection[index]),
              title: Text(_colorNames[index]),
              onTap: () {
                setState(
                  () {
                    _selectedColorIndex = index;
                  },
                );
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
