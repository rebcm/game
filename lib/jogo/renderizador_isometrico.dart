import 'dart:math';
import 'package:flutter/material.dart';
import '../blocos/tipo_bloco.dart';
import '../mundo/mundo.dart';
import '../mundo/posicao3d.dart';
import '../personagem/rebeca.dart';
import '../config/constantes.dart';

class RenderizadorIsometrico extends CustomPainter {
  final Mundo mundo;
  final Rebeca rebeca;
  final double escala;

  static const double angIso = 30.0 * (pi / 180.0);
  static const double lb = Constantes.tamanhoBloco;
  static const double ab = Constantes.tamanhoBloco * 0.5;

  const RenderizadorIsometrico({
    required this.mundo,
    required this.rebeca,
    this.escala = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 3);
    canvas.scale(escala);

    final cx = rebeca.x.floor();
    final cy = rebeca.y.floor();
    final cz = rebeca.z.floor();
    const raio = 10;

    for (var y = 0; y <= cy; y++) {
      for (var x = cx - raio; x <= cx + raio; x++) {
        for (var z = cz + raio; z >= cz - raio; z--) {
          final pos = Posicao3D(x, y, z);
          final bloco = mundo.pegarBloco(pos);
          if (bloco == TipoBloco.ar) continue;
          final tela = _paraIso(x.toDouble(), y.toDouble(), z.toDouble());
          _desenharBloco(canvas, tela, bloco);
        }
      }
    }

    final posRebeca = _paraIso(rebeca.x, cy.toDouble(), rebeca.z);
    rebeca.pintar(canvas, posRebeca);

    canvas.restore();
  }

  Offset _paraIso(double x, double y, double z) {
    final tx = (x - z) * cos(angIso) * lb;
    final ty = (x + z) * sin(angIso) * ab - y * ab;
    return Offset(tx, ty);
  }

  void _desenharBloco(Canvas canvas, Offset pos, TipoBloco tipo) {
    _faceTopo(canvas, pos, tipo);
    _faceEsquerda(canvas, pos, tipo);
    _faceDireita(canvas, pos, tipo);
  }

  void _faceTopo(Canvas canvas, Offset pos, TipoBloco tipo) {
    final paint = Paint()..color = tipo.cor;
    final path = Path()
      ..moveTo(pos.dx, pos.dy - ab)
      ..lineTo(pos.dx + lb / 2, pos.dy - ab / 2)
      ..lineTo(pos.dx, pos.dy)
      ..lineTo(pos.dx - lb / 2, pos.dy - ab / 2)
      ..close();
    canvas.drawPath(path, paint);
    paint
      ..color = Colors.black.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawPath(path, paint);
  }

  void _faceEsquerda(Canvas canvas, Offset pos, TipoBloco tipo) {
    final paint = Paint()..color = tipo.cor.withValues(alpha: 0.7);
    final path = Path()
      ..moveTo(pos.dx - lb / 2, pos.dy - ab / 2)
      ..lineTo(pos.dx, pos.dy)
      ..lineTo(pos.dx, pos.dy + ab)
      ..lineTo(pos.dx - lb / 2, pos.dy + ab / 2)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _faceDireita(Canvas canvas, Offset pos, TipoBloco tipo) {
    final paint = Paint()..color = tipo.cor.withValues(alpha: 0.55);
    final path = Path()
      ..moveTo(pos.dx, pos.dy)
      ..lineTo(pos.dx + lb / 2, pos.dy - ab / 2)
      ..lineTo(pos.dx + lb / 2, pos.dy + ab / 2)
      ..lineTo(pos.dx, pos.dy + ab)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RenderizadorIsometrico antigo) => true;
}
