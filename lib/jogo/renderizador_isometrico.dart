import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/performance/analisador_performance.dart';

class RenderizadorIsometrico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnalisadorPerformance>(
      builder: (context, analisador, child) {
        return analisador.wrapWithRepaintRainbow(
          CustomPaint(
            painter: _RenderizadorIsometricoPainter(),
          ),
        );
      },
    );
  }
}

class _RenderizadorIsometricoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Lógica de renderização existente
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Lógica de shouldRepaint existente
  }
}
