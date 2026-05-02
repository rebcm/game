import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:game/personagem/rebeca.dart';

class RenderizadorIsometrico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rebeca = Provider.of<Rebeca>(context);
    return CustomPaint(
      painter: _RenderizadorIsometricoPainter(rebeca),
    );
  }
}

class _RenderizadorIsometricoPainter extends CustomPainter {
  final Rebeca _rebeca;

  _RenderizadorIsometricoPainter(this._rebeca);

  @override
  void paint(Canvas canvas, Size size) {
    // Render Rebeca
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(_rebeca.x, _rebeca.y),
        width: 10,
        height: 10,
      ),
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
