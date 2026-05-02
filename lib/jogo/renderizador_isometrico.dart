import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/ui/personagem_view.dart';

class RenderizadorIsometrico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ... outros elementos do jogo
        PersonagemView(),
      ],
    );
  }
}
