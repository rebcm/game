import 'package:flutter/material.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';

class RenderizadorIsometrico extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Desenhar um cubo simples como protótipo
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Projeção isométrica básica
    Offset centro = Offset(size.width / 2, size.height / 2);
    canvas.drawPath(
      Path()
        ..moveTo(centro.dx, centro.dy - 20)
        ..lineTo(centro.dx + 20, centro.dy)
        ..lineTo(centro.dx, centro.dy + 20)
        ..lineTo(centro.dx - 20, centro.dy)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
