import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';

class RenderizadorIsometrico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _RenderizadorIsometricoPainter(),
      ),
    );
  }
}

class _RenderizadorIsometricoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Implementação existente do renderizador isométrico
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
