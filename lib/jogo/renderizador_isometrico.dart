import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/animações/animacao_blocos.dart';

class RenderizadorIsometrico extends StatelessWidget {
  final AnimacaoBlocos _animacaoBlocos = AnimacaoBlocos();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _IsometricPainter(_animacaoBlocos),
    );
  }
}

class _IsometricPainter extends CustomPainter {
  final AnimacaoBlocos _animacaoBlocos;

  _IsometricPainter(this._animacaoBlocos);

  @override
  void paint(Canvas canvas, Size size) {
    // Implementação da pintura isométrica
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
