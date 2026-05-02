import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:rebcm/mundo/gerador.dart';

class RenderizadorIsometricoModificado extends StatefulWidget {
  @override
  _RenderizadorIsometricoModificadoState createState() => _RenderizadorIsometricoModificadoState();
}

class _RenderizadorIsometricoModificadoState extends State<RenderizadorIsometricoModificado> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          if (_isHovering) {
            print('Clicked on the isometric renderer');
          }
        },
        child: CustomPaint(
          painter: RenderizadorIsometricoPainter(),
          size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        ),
      ),
    );
  }
}

class RenderizadorIsometricoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Existing painting logic here
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
