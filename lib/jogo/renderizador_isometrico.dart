import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';

class RenderizadorIsometrico extends StatefulWidget {
  @override
  _RenderizadorIsometricoState createState() => _RenderizadorIsometricoState();
}

class _RenderizadorIsometricoState extends State<RenderizadorIsometrico> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => print('Mouse entered'),
      onExit: (event) => print('Mouse exited'),
      onHover: (event) => print('Mouse hovered'),
      child: GestureDetector(
        onTap: () => print('Tapped'),
        child: CustomPaint(
          painter: _IsometricPainter(),
        ),
      ),
    );
  }
}

class _IsometricPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Existing painting logic here
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
