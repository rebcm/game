import 'dart:ui';
import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mundo/mundo.dart';
import 'package:rebcm/personagem/rebeca.dart';

class _Quad {
  final Path path;
  final Color color;
  final double sortKey;
  final bool isOverlay;
  _Quad(this.path, this.color, this.sortKey, {this.isOverlay = false});
}

class RenderizadorIsometrico {
  // Camera angle: 0=NE, 1=SE, 2=SW, 3=NW
  int camAngle = 0;

  final _fillPaint = Paint()..style = PaintingStyle.fill;
  final _strokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5
    ..color = const Color(0x55000000);
  final _highlightPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5
    ..color = const Color(0xFFFFFFFF);

  void render(Canvas canvas, Mundo mundo, Rebeca rebeca, Vector2 tela) {
    _desenharCeu(canvas, tela);

    final cx = tela.x / 2 - rebeca.telaX;
    final cy = tela.y / 2 - rebeca.telaY;

    final quads = <_Quad>[];
    Path? highlightPath;

    for (int bx = 0; bx < mundo.largura; bx++) {
      for (int bz = 0; bz < mundo.profundidade; bz++) {
        for (int by = 0; by < mundo.altura; by++) {
          final bloco = mundo.get(bx, by, bz);
          if (!bloco.solido) continue;

          final proj = _project(bx.toDouble(), by.toDouble(), bz.toDouble());
          final sx = cx + proj.$1;
          final sy = cy + proj.$2;

          // Frustum cull
          if (sx < -Constantes.halfW * 3 || sx > tela.x + Constantes.halfW * 3) continue;
          if (sy < -Constantes.sideH * 3 || sy > tela.y + Constantes.sideH * 3) continue;

          final topoV = !mundo.isSolido(bx, by + 1, bz);
          final f1V = _face1Visivel(bx, by, bz, mundo);
          final f2V = _face2Visivel(bx, by, bz, mundo);
          if (!topoV && !f1V && !f2V) continue;

          final bool isAlvo = rebeca.blocoAlvo != null &&
              rebeca.blocoAlvo!.x == bx &&
              rebeca.blocoAlvo!.y == by &&
              rebeca.blocoAlvo!.z == bz;

          final double sk = _sortKey(bx, by, bz);

          if (topoV) quads.add(_buildTop(sx, sy, bloco.corTopo, sk));
          if (f1V) quads.add(_buildFace1(sx, sy, bloco.corEsquerda, sk - 0.1));
          if (f2V) quads.add(_buildFace2(sx, sy, bloco.corDireita, sk - 0.2));

          // Breaking cracks
          if (isAlvo && rebeca.progressoQuebra > 0) {
            final stage = (rebeca.progressoQuebra * 4).floor().clamp(1, 4);
            final alpha = (stage * 50).clamp(0, 200);
            final crackColor = Color.fromARGB(alpha, 0, 0, 0);
            if (topoV) quads.add(_buildTop(sx, sy, crackColor, sk + 0.6, isOverlay: true));
            if (f1V) quads.add(_buildFace1(sx, sy, crackColor, sk + 0.5, isOverlay: true));
            if (f2V) quads.add(_buildFace2(sx, sy, crackColor, sk + 0.4, isOverlay: true));
            // Crack lines
            if (topoV) quads.add(_crackLines(sx, sy, 'top', stage, sk + 0.7));
            if (f1V) quads.add(_crackLines(sx, sy, 'f1', stage, sk + 0.65));
            if (f2V) quads.add(_crackLines(sx, sy, 'f2', stage, sk + 0.62));
          }

          if (isAlvo) {
            highlightPath = _buildHighlightPath(sx, sy, topoV, f1V, f2V);
          }
        }
      }
    }

    quads.sort((a, b) => a.sortKey.compareTo(b.sortKey));

    for (final q in quads) {
      _fillPaint.color = q.color;
      canvas.drawPath(q.path, _fillPaint);
      if (!q.isOverlay) canvas.drawPath(q.path, _strokePaint);
    }

    if (highlightPath != null) {
      canvas.drawPath(highlightPath!, _highlightPaint);
    }

    _desenharRebeca(canvas, cx, cy, rebeca);
    _desenharMao(canvas, tela, rebeca.blocoSelecionado);
    _desenharMirinha(canvas, tela);
  }

  (double, double) _project(double bx, double by, double bz) {
    double rx = bx, rz = bz;
    final W = Constantes.worldX - 1.0;
    switch (camAngle) {
      case 1:
        final tmp = rx; rx = W - rz; rz = tmp;
      case 2:
        rx = W - rx; rz = W - rz;
      case 3:
        final tmp = rx; rx = rz; rz = W - tmp;
    }
    return (
      (rx - rz) * Constantes.halfW,
      (rx + rz) * Constantes.halfH - by * Constantes.sideH,
    );
  }

  double _sortKey(int bx, int by, int bz) {
    double rx = bx.toDouble(), rz = bz.toDouble();
    final W = Constantes.worldX - 1.0;
    switch (camAngle) {
      case 1:
        final tmp = rx; rx = W - rz; rz = tmp;
      case 2:
        rx = W - rx; rz = W - rz;
      case 3:
        final tmp = rx; rx = rz; rz = W - tmp;
    }
    return (rx + rz) * 1000.0 + by.toDouble();
  }

  bool _face1Visivel(int bx, int by, int bz, Mundo mundo) {
    switch (camAngle) {
      case 0: return !mundo.isSolido(bx - 1, by, bz);
      case 1: return !mundo.isSolido(bx, by, bz + 1);
      case 2: return !mundo.isSolido(bx + 1, by, bz);
      case 3: return !mundo.isSolido(bx, by, bz - 1);
      default: return !mundo.isSolido(bx - 1, by, bz);
    }
  }

  bool _face2Visivel(int bx, int by, int bz, Mundo mundo) {
    switch (camAngle) {
      case 0: return !mundo.isSolido(bx, by, bz - 1);
      case 1: return !mundo.isSolido(bx - 1, by, bz);
      case 2: return !mundo.isSolido(bx, by, bz + 1);
      case 3: return !mundo.isSolido(bx + 1, by, bz);
      default: return !mundo.isSolido(bx, by, bz - 1);
    }
  }

  _Quad _buildTop(double sx, double sy, Color color, double sk, {bool isOverlay = false}) {
    final hw = Constantes.halfW, hh = Constantes.halfH;
    final p = Path()
      ..moveTo(sx, sy - hh)
      ..lineTo(sx + hw, sy)
      ..lineTo(sx, sy + hh)
      ..lineTo(sx - hw, sy)
      ..close();
    return _Quad(p, color, sk, isOverlay: isOverlay);
  }

  _Quad _buildFace1(double sx, double sy, Color color, double sk, {bool isOverlay = false}) {
    final hw = Constantes.halfW, hh = Constantes.halfH, sh = Constantes.sideH;
    final p = Path()
      ..moveTo(sx - hw, sy)
      ..lineTo(sx, sy + hh)
      ..lineTo(sx, sy + hh + sh)
      ..lineTo(sx - hw, sy + sh)
      ..close();
    return _Quad(p, color, sk, isOverlay: isOverlay);
  }

  _Quad _buildFace2(double sx, double sy, Color color, double sk, {bool isOverlay = false}) {
    final hw = Constantes.halfW, hh = Constantes.halfH, sh = Constantes.sideH;
    final p = Path()
      ..moveTo(sx, sy + hh)
      ..lineTo(sx + hw, sy)
      ..lineTo(sx + hw, sy + sh)
      ..lineTo(sx, sy + hh + sh)
      ..close();
    return _Quad(p, color, sk, isOverlay: isOverlay);
  }

  _Quad _crackLines(double sx, double sy, String face, int stage, double sk) {
    final hw = Constantes.halfW, hh = Constantes.halfH, sh = Constantes.sideH;
    final p = Path();
    for (int i = 1; i <= stage; i++) {
      final t = i / (stage + 1.0);
      switch (face) {
        case 'top':
          p.moveTo(sx - hw * t, sy);
          p.lineTo(sx + hw * (1 - t), sy - hh + hh * t * 2);
          p.moveTo(sx + hw * t, sy);
          p.lineTo(sx - hw * (1 - t), sy - hh + hh * t * 2);
        case 'f1':
          p.moveTo(sx - hw, sy + sh * t);
          p.lineTo(sx, sy + hh + sh * t * 0.8);
        case 'f2':
          p.moveTo(sx, sy + hh + sh * t);
          p.lineTo(sx + hw, sy + sh * t);
      }
    }
    return _Quad(p, const Color(0xBB000000), sk, isOverlay: true);
  }

  Path _buildHighlightPath(double sx, double sy, bool top, bool f1, bool f2) {
    final hw = Constantes.halfW, hh = Constantes.halfH, sh = Constantes.sideH;
    final p = Path();
    if (top) {
      p.moveTo(sx, sy - hh);
      p.lineTo(sx + hw, sy);
      p.lineTo(sx, sy + hh);
      p.lineTo(sx - hw, sy);
      p.close();
    }
    if (f1) {
      p.moveTo(sx - hw, sy);
      p.lineTo(sx, sy + hh);
      p.lineTo(sx, sy + hh + sh);
      p.lineTo(sx - hw, sy + sh);
      p.close();
    }
    if (f2) {
      p.moveTo(sx, sy + hh);
      p.lineTo(sx + hw, sy);
      p.lineTo(sx + hw, sy + sh);
      p.lineTo(sx, sy + hh + sh);
      p.close();
    }
    return p;
  }

  void _desenharCeu(Canvas canvas, Vector2 tela) {
    final rect = Rect.fromLTWH(0, 0, tela.x, tela.y);
    final gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF1E88E5), Color(0xFF87CEEB)],
    ).createShader(rect);
    canvas.drawRect(rect, Paint()..shader = gradient);

    // Clouds (simple white ovals)
    final cloudPaint = Paint()..color = const Color(0xCCFFFFFF);
    for (int i = 0; i < 5; i++) {
      final cx2 = (i * 0.2 + 0.1) * tela.x;
      final cy2 = tela.y * 0.15;
      canvas.drawOval(Rect.fromCenter(center: Offset(cx2, cy2), width: 70, height: 22), cloudPaint);
      canvas.drawOval(Rect.fromCenter(center: Offset(cx2 + 25, cy2 - 8), width: 50, height: 18), cloudPaint);
    }
  }

  void _desenharRebeca(Canvas canvas, double cx, double cy, Rebeca rebeca) {
    final sx = cx + rebeca.telaX;
    final sy = cy + rebeca.telaY;

    // Ground shadow
    canvas.drawOval(
      Rect.fromCenter(center: Offset(sx, sy + 14), width: 24, height: 9),
      Paint()
        ..color = const Color(0x44000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    // Body (pink isometric diamond)
    final fill = Paint()..style = PaintingStyle.fill..color = const Color(0xFFE91E63);
    final body = Path()
      ..moveTo(sx, sy - 18)
      ..lineTo(sx + 12, sy - 2)
      ..lineTo(sx, sy + 14)
      ..lineTo(sx - 12, sy - 2)
      ..close();
    canvas.drawPath(body, fill);

    // Shirt/body detail (slightly lighter stripe)
    fill.color = const Color(0xFFAD1457);
    final shirt = Path()
      ..moveTo(sx - 7, sy + 2)
      ..lineTo(sx, sy - 4)
      ..lineTo(sx + 7, sy + 2)
      ..lineTo(sx, sy + 10)
      ..close();
    canvas.drawPath(shirt, fill);

    // White outline
    canvas.drawPath(body, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xCCFFFFFF));

    // Eyes
    canvas.drawCircle(Offset(sx - 4, sy - 7), 2.5, Paint()..color = const Color(0xFFFFFFFF));
    canvas.drawCircle(Offset(sx + 4, sy - 7), 2.5, Paint()..color = const Color(0xFFFFFFFF));
    canvas.drawCircle(Offset(sx - 4, sy - 7), 1.2, Paint()..color = const Color(0xFF1A237E));
    canvas.drawCircle(Offset(sx + 4, sy - 7), 1.2, Paint()..color = const Color(0xFF1A237E));
  }

  // Player hand — mini isometric cube in bottom-right
  void _desenharMao(Canvas canvas, Vector2 tela, TipoBloco bloco) {
    if (bloco == TipoBloco.ar) return;
    final cx = tela.x - 80.0;
    final cy = tela.y - 80.0;
    const hw = 24.0, hh = 12.0, sh = 24.0;
    final fill = Paint()..style = PaintingStyle.fill;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0x99000000);

    // Background circle
    canvas.drawCircle(
      Offset(cx, cy + hh + sh / 2),
      42,
      Paint()..color = const Color(0x44000000),
    );

    // Right face
    fill.color = bloco.corDireita;
    final right = Path()
      ..moveTo(cx, cy + hh)..lineTo(cx + hw, cy)
      ..lineTo(cx + hw, cy + sh)..lineTo(cx, cy + hh + sh)..close();
    canvas.drawPath(right, fill);
    canvas.drawPath(right, stroke);

    // Left face
    fill.color = bloco.corEsquerda;
    final left = Path()
      ..moveTo(cx - hw, cy)..lineTo(cx, cy + hh)
      ..lineTo(cx, cy + hh + sh)..lineTo(cx - hw, cy + sh)..close();
    canvas.drawPath(left, fill);
    canvas.drawPath(left, stroke);

    // Top face
    fill.color = bloco.corTopo;
    final top = Path()
      ..moveTo(cx, cy - hh)..lineTo(cx + hw, cy)
      ..lineTo(cx, cy + hh)..lineTo(cx - hw, cy)..close();
    canvas.drawPath(top, fill);
    canvas.drawPath(top, stroke);
  }

  // Center crosshair
  void _desenharMirinha(Canvas canvas, Vector2 tela) {
    final cx = tela.x / 2;
    final cy = tela.y / 2;
    const size = 11.0, gap = 4.0, thick = 2.0;

    final shadow = Paint()
      ..color = const Color(0x88000000)
      ..strokeWidth = thick + 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final white = Paint()
      ..color = const Color(0xEEFFFFFF)
      ..strokeWidth = thick
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final p in [shadow, white]) {
      canvas.drawLine(Offset(cx - size, cy), Offset(cx - gap, cy), p);
      canvas.drawLine(Offset(cx + gap, cy), Offset(cx + size, cy), p);
      canvas.drawLine(Offset(cx, cy - size), Offset(cx, cy - gap), p);
      canvas.drawLine(Offset(cx, cy + gap), Offset(cx, cy + size), p);
    }
    // Center dot
    canvas.drawCircle(Offset(cx, cy), 1.5, Paint()..color = const Color(0xEEFFFFFF));
  }

  void rotacionarCamera() => camAngle = (camAngle + 1) % 4;
}
