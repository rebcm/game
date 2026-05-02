import 'package:flutter/material.dart';
import 'package:rebcm/blocos/logica_blocos.dart';

class HUD extends StatelessWidget {
  final LogicaBlocos _logicaBlocos = LogicaBlocos();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _logicaBlocos.colocarBloco(TipoBloco.Terra, 0, 0, 0);
          },
          child: Text('Colocar Bloco'),
        ),
        ElevatedButton(
          onPressed: () {
            _logicaBlocos.quebrarBloco(0, 0, 0);
          },
          child: Text('Quebrar Bloco'),
        ),
      ],
    );
  }
}
