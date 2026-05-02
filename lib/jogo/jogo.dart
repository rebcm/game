import 'package:flutter/material.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

class Jogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: RenderizadorIsometrico(),
          size: Size(200, 200),
        ),
      ),
    );
  }
}
