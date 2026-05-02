import 'package:flutter/material.dart';

class RenderizadorIsometrico extends StatefulWidget {
  @override
  _RenderizadorIsometricoState createState() => _RenderizadorIsometricoState();
}

class _RenderizadorIsometricoState extends State<RenderizadorIsometrico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: _IsometricPainter(),
      ),
    );
  }
}

class _IsometricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Implementação do renderizador isométrico
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
