import 'dart:ui';
import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/constantes.dart';
import 'package:rebcm/mob/mob.dart';
import 'package:rebcm/mundo/mundo.dart';
import 'package:rebcm/personagem/rebeca.dart';

class _Quad {
  final Path path;
  final Color color;
  final double sortKey;
  final bool isOverlay;
  _Quad(this.path, this.color, this.sortKey, {this.isOverlay = false});
}

/// Renderiza o mundo isométrico em torno do player, varrendo apenas os chunks
/// dentro de [Constantes.viewRadius]. A rotação de câmera é discreta em 4
/// passos (NE/SE/SW/NW) e gira em torno da posição do player — coerente para
/// mundo infinito por chunks.
class RenderizadorIsometrico {
  // Camera angle: 0=NE, 1=SE, 2=SW, 3=NW
  int camAngle = 0;

  // Atmosfera dinâmica (0..1) — 0 = noite, 1 = dia.
  double luzDia = 1.0;

  final _fillPaint = Paint()..style = PaintingStyle.fill;
  final _strokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5
    ..color = const Color(0x55000000);
  final _highlightPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5
    ..color = const Color(0xFFFFFFFF);

  void render(
    Canvas canvas,
    Mundo mundo,
    Rebeca rebeca,
    Vector2 tela, {
    List<Mob> mobs = const [],
  }) {
    _desenharCeu(canvas, tela);

    // Translação para centralizar o player na tela.
    final telaPlayer = _projetarMundo(rebeca.x, rebeca.y, rebeca.z);
    final cx = tela.x / 2 - telaPlayer.$1;
    final cy = tela.y / 2 - telaPlayer.$2;

    // Range de iteração em torno do player.
    final cs = Constantes.chunkSize;
    final pcx = (rebeca.x / cs).floor();
    final pcz = (rebeca.z / cs).floor();
    final r = Constantes.viewRadius;
    final xMin = (pcx - r) * cs;
    final xMax = (pcx + r + 1) * cs;
    final zMin = (pcz - r) * cs;
    final zMax = (pcz + r + 1) * cs;

    final quads = <_Quad>[];
    Path? highlightPath;

    for (int bx = xMin; bx < xMax; bx++) {
      for (int bz = zMin; bz < zMax; bz++) {
        // Pular colunas vazias rápido (terreno sem blocos sólidos).
        final hSurf = mundo.alturaSuperficie(bx, bz);
        // Iteramos até hSurf+8 para incluir folhas de árvores acima do solo
        // e blocos colocados pelo player ligeiramente acima do terreno.
        // Blocos colocados muito alto também aparecem se alturaSuperficie
        // já refletiu eles (alturaSuperficie consulta worldY-1 down to 0).
        final yMax = (hSurf + 8).clamp(0, Constantes.worldY - 1);
        for (int by = 0; by <= yMax; by++) {
          final bloco = mundo.get(bx, by, bz);
          if (!bloco.solido) continue;

          final proj = _projetarMundo(bx.toDouble(), by.toDouble(), bz.toDouble());
          final sx = cx + proj.$1;
          final sy = cy + proj.$2;

          // Frustum cull rápido.
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

          // Sort key relativo à posição do player.
          final sk = _sortKey(bx, by, bz, rebeca.x, rebeca.z);

          final corTopo = _aplicarLuz(bloco.corTopo, by, bloco.emiteLuz);
          final corEsq = _aplicarLuz(bloco.corEsquerda, by, bloco.emiteLuz);
          final corDir = _aplicarLuz(bloco.corDireita, by, bloco.emiteLuz);

          if (topoV) quads.add(_buildTop(sx, sy, corTopo, sk));
          if (f1V) quads.add(_buildFace1(sx, sy, corEsq, sk - 0.1));
          if (f2V) quads.add(_buildFace2(sx, sy, corDir, sk - 0.2));

          if (isAlvo && rebeca.progressoQuebra > 0) {
            final stage = (rebeca.progressoQuebra * 4).floor().clamp(1, 4);
            final alpha = (stage * 50).clamp(0, 200);
            final crackColor = Color.fromARGB(alpha, 0, 0, 0);
            if (topoV) quads.add(_buildTop(sx, sy, crackColor, sk + 0.6, isOverlay: true));
            if (f1V) quads.add(_buildFace1(sx, sy, crackColor, sk + 0.5, isOverlay: true));
            if (f2V) quads.add(_buildFace2(sx, sy, crackColor, sk + 0.4, isOverlay: true));
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
      canvas.drawPath(highlightPath, _highlightPaint);
    }

    _desenharMobs(canvas, cx, cy, mobs);
    _desenharRebeca(canvas, cx, cy, rebeca);
    _desenharMao(canvas, tela, rebeca.blocoSelecionado);
    _desenharMirinha(canvas, tela);
  }

  /// Aplica fator de luz (dia/noite) à cor de um bloco. Blocos que emitem
  /// luz própria não são escurecidos. A luz cai com a profundidade abaixo
  /// do solo para sugerir cavernas escuras.
  Color _aplicarLuz(Color c, int y, bool emite) {
    if (emite) return c;
    // Curva: luzDia=1 → fator 1; luzDia=0 → fator 0.35.
    double f = 0.35 + 0.65 * luzDia;
    // Atenuação de profundidade: y baixo escurece um pouco.
    if (y < 5) f *= 0.85;
    return Color.fromARGB(
      c.alpha,
      (c.red * f).clamp(0, 255).toInt(),
      (c.green * f).clamp(0, 255).toInt(),
      (c.blue * f).clamp(0, 255).toInt(),
    );
  }

  /// Projeta coordenadas globais (x,y,z) para a tela isométrica, aplicando
  /// rotação de câmera em torno da origem (a translação para o player é
  /// feita pelo caller).
  (double, double) _projetarMundo(double bx, double by, double bz) {
    double rx = bx, rz = bz;
    switch (camAngle) {
      case 1:
        // 90° CCW: (x,z) → (-z, x)
        final tmp = rx;
        rx = -rz;
        rz = tmp;
      case 2:
        rx = -rx;
        rz = -rz;
      case 3:
        final tmp = rx;
        rx = rz;
        rz = -tmp;
    }
    return (
      (rx - rz) * Constantes.halfW,
      (rx + rz) * Constantes.halfH - by * Constantes.sideH,
    );
  }

  double _sortKey(int bx, int by, int bz, double px, double pz) {
    double rx = bx.toDouble(), rz = bz.toDouble();
    switch (camAngle) {
      case 1:
        final tmp = rx;
        rx = -rz;
        rz = tmp;
      case 2:
        rx = -rx;
        rz = -rz;
      case 3:
        final tmp = rx;
        rx = rz;
        rz = -tmp;
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
    // Mistura entre cor de dia e cor de noite conforme luzDia.
    final cTopoDia = const Color(0xFF1E88E5);
    final cBaseDia = const Color(0xFF87CEEB);
    final cTopoNoite = const Color(0xFF0B1430);
    final cBaseNoite = const Color(0xFF1A2147);

    final t = luzDia.clamp(0.0, 1.0);
    final cTopo = Color.lerp(cTopoNoite, cTopoDia, t)!;
    final cBase = Color.lerp(cBaseNoite, cBaseDia, t)!;
    final rect = Rect.fromLTWH(0, 0, tela.x, tela.y);
    final shader = Gradient.linear(
      Offset(rect.center.dx, rect.top),
      Offset(rect.center.dx, rect.bottom),
      [cTopo, cBase],
    );
    canvas.drawRect(rect, Paint()..shader = shader);

    if (t > 0.5) {
      // Nuvens visíveis durante o dia.
      final cloudPaint = Paint()
        ..color = Color.fromARGB((220 * t).toInt(), 255, 255, 255);
      for (int i = 0; i < 5; i++) {
        final cx2 = (i * 0.2 + 0.1) * tela.x;
        final cy2 = tela.y * 0.15;
        canvas.drawOval(Rect.fromCenter(center: Offset(cx2, cy2), width: 70, height: 22), cloudPaint);
        canvas.drawOval(Rect.fromCenter(center: Offset(cx2 + 25, cy2 - 8), width: 50, height: 18), cloudPaint);
      }
    } else {
      // Estrelas durante a noite.
      final starPaint = Paint()
        ..color = Color.fromARGB((255 * (1.0 - t)).toInt(), 255, 255, 230);
      for (int i = 0; i < 30; i++) {
        // Posições pseudo-aleatórias estáveis por sessão.
        final sx = (i * 137 % tela.x.toInt()).toDouble();
        final sy = (i * 71 % (tela.y.toInt() ~/ 2)).toDouble();
        canvas.drawCircle(Offset(sx, sy), 1.0, starPaint);
      }
    }
  }

  void _desenharRebeca(Canvas canvas, double cx, double cy, Rebeca rebeca) {
    // Player sempre fica no centro da tela — a translação cx/cy compensa
    // sua posição global, então desenhamos relativo a (cx + telaPlayer).
    final telaPlayer = _projetarMundo(rebeca.x, rebeca.y, rebeca.z);
    final sx = cx + telaPlayer.$1;
    final sy = cy + telaPlayer.$2;

    canvas.drawOval(
      Rect.fromCenter(center: Offset(sx, sy + 14), width: 24, height: 9),
      Paint()
        ..color = const Color(0x44000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    final fill = Paint()..style = PaintingStyle.fill..color = const Color(0xFFE91E63);
    final body = Path()
      ..moveTo(sx, sy - 18)
      ..lineTo(sx + 12, sy - 2)
      ..lineTo(sx, sy + 14)
      ..lineTo(sx - 12, sy - 2)
      ..close();
    canvas.drawPath(body, fill);

    fill.color = const Color(0xFFAD1457);
    final shirt = Path()
      ..moveTo(sx - 7, sy + 2)
      ..lineTo(sx, sy - 4)
      ..lineTo(sx + 7, sy + 2)
      ..lineTo(sx, sy + 10)
      ..close();
    canvas.drawPath(shirt, fill);

    canvas.drawPath(body, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xCCFFFFFF));

    canvas.drawCircle(Offset(sx - 4, sy - 7), 2.5, Paint()..color = const Color(0xFFFFFFFF));
    canvas.drawCircle(Offset(sx + 4, sy - 7), 2.5, Paint()..color = const Color(0xFFFFFFFF));
    canvas.drawCircle(Offset(sx - 4, sy - 7), 1.2, Paint()..color = const Color(0xFF1A237E));
    canvas.drawCircle(Offset(sx + 4, sy - 7), 1.2, Paint()..color = const Color(0xFF1A237E));
  }

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

    canvas.drawCircle(
      Offset(cx, cy + hh + sh / 2),
      42,
      Paint()..color = const Color(0x44000000),
    );

    fill.color = bloco.corDireita;
    final right = Path()
      ..moveTo(cx, cy + hh)..lineTo(cx + hw, cy)
      ..lineTo(cx + hw, cy + sh)..lineTo(cx, cy + hh + sh)..close();
    canvas.drawPath(right, fill);
    canvas.drawPath(right, stroke);

    fill.color = bloco.corEsquerda;
    final left = Path()
      ..moveTo(cx - hw, cy)..lineTo(cx, cy + hh)
      ..lineTo(cx, cy + hh + sh)..lineTo(cx - hw, cy + sh)..close();
    canvas.drawPath(left, fill);
    canvas.drawPath(left, stroke);

    fill.color = bloco.corTopo;
    final top = Path()
      ..moveTo(cx, cy - hh)..lineTo(cx + hw, cy)
      ..lineTo(cx, cy + hh)..lineTo(cx - hw, cy)..close();
    canvas.drawPath(top, fill);
    canvas.drawPath(top, stroke);
  }

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
    canvas.drawCircle(Offset(cx, cy), 1.5, Paint()..color = const Color(0xEEFFFFFF));
  }

  /// Desenha todos os mobs ordenados por profundidade isométrica para que
  /// os mais ao fundo apareçam atrás dos da frente.
  void _desenharMobs(Canvas canvas, double cx, double cy, List<Mob> mobs) {
    if (mobs.isEmpty) return;
    final ordenados = [...mobs];
    ordenados.sort((a, b) {
      final keyA = _sortKeyMob(a);
      final keyB = _sortKeyMob(b);
      return keyA.compareTo(keyB);
    });
    for (final m in ordenados) {
      final proj = _projetarMundo(m.x, m.y, m.z);
      final sx = cx + proj.$1;
      final sy = cy + proj.$2;
      _desenharMob(canvas, sx, sy, m);
    }
  }

  double _sortKeyMob(Mob m) {
    double rx = m.x, rz = m.z;
    switch (camAngle) {
      case 1:
        final tmp = rx;
        rx = -rz;
        rz = tmp;
      case 2:
        rx = -rx;
        rz = -rz;
      case 3:
        final tmp = rx;
        rx = rz;
        rz = -tmp;
    }
    return (rx + rz) * 1000.0 + m.y;
  }

  void _desenharMob(Canvas canvas, double sx, double sy, Mob m) {
    // Sombra.
    canvas.drawOval(
      Rect.fromCenter(center: Offset(sx, sy + 14), width: 22, height: 8),
      Paint()
        ..color = const Color(0x55000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    final corPrim = Color(_aplicarLuzARGB(m.tipo.corARGB));
    final corSec = Color(_aplicarLuzARGB(m.tipo.corARGBSecundaria));

    // Corpo: diamante isométrico ligeiramente maior que o player.
    final corpo = Path()
      ..moveTo(sx, sy - 16)
      ..lineTo(sx + 13, sy - 1)
      ..lineTo(sx, sy + 14)
      ..lineTo(sx - 13, sy - 1)
      ..close();
    canvas.drawPath(corpo, Paint()..color = corPrim);

    // Manchas/detalhe.
    final mancha = Path()
      ..moveTo(sx - 6, sy + 2)
      ..lineTo(sx, sy - 4)
      ..lineTo(sx + 6, sy + 2)
      ..lineTo(sx, sy + 8)
      ..close();
    canvas.drawPath(mancha, Paint()..color = corSec);

    // Outline.
    canvas.drawPath(
      corpo,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = const Color(0x88000000),
    );

    // Olhos.
    final olhoBranco = Paint()..color = const Color(0xFFFFFFFF);
    final olhoPupila = Paint()..color = m.tipo.hostil ? const Color(0xFFD32F2F) : const Color(0xFF1A237E);
    canvas.drawCircle(Offset(sx - 3, sy - 6), 2.0, olhoBranco);
    canvas.drawCircle(Offset(sx + 3, sy - 6), 2.0, olhoBranco);
    canvas.drawCircle(Offset(sx - 3, sy - 6), 1.0, olhoPupila);
    canvas.drawCircle(Offset(sx + 3, sy - 6), 1.0, olhoPupila);

    // Bico/focinho.
    if (m.tipo == TipoMob.galinha) {
      final bico = Path()
        ..moveTo(sx, sy - 3)
        ..lineTo(sx + 3, sy - 1)
        ..lineTo(sx, sy + 1)
        ..close();
      canvas.drawPath(bico, Paint()..color = const Color(0xFFFF6F00));
    }

    // Barra de HP fininha acima quando dano.
    if (m.hp < m.tipo.hpMax) {
      final pct = m.hp / m.tipo.hpMax;
      final wTotal = 22.0;
      final left = sx - wTotal / 2;
      final top = sy - 24;
      canvas.drawRect(
        Rect.fromLTWH(left, top, wTotal, 3),
        Paint()..color = const Color(0xAA000000),
      );
      canvas.drawRect(
        Rect.fromLTWH(left, top, wTotal * pct, 3),
        Paint()..color = const Color(0xFFE53935),
      );
    }
  }

  /// Versão de [_aplicarLuz] que opera sobre um inteiro ARGB direto.
  int _aplicarLuzARGB(int argb) {
    final a = (argb >> 24) & 0xFF;
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;
    final f = 0.35 + 0.65 * luzDia;
    final nr = (r * f).clamp(0, 255).toInt();
    final ng = (g * f).clamp(0, 255).toInt();
    final nb = (b * f).clamp(0, 255).toInt();
    return (a << 24) | (nr << 16) | (ng << 8) | nb;
  }

  void rotacionarCamera() => camAngle = (camAngle + 1) % 4;
}
