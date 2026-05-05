import 'dart:math' as math;
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

class _Luz {
  final double x, y, z;
  final int nivel; // 1..15
  const _Luz(this.x, this.y, this.z, this.nivel);
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
  // Fração 0..1 do dia, controla posição de sol/lua.
  double tempoDia = 0.25;
  // Offset de animação acumulado (para nuvens em movimento).
  double tempoAnim = 0.0;

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
    TipoBloco? blocoMao,
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

    // === Pré-scan: coleta luzes ativas no range, via cache por chunk. ===
    // ChunkMundo.iterarLuzes só visita os índices marcados como luminosos
    // (cache invalidado quando chunk dirty). Cap total para perf.
    final luzes = <_Luz>[];
    for (final l in mundo.chunks.iterarLuzes(pcx - r, pcx + r, pcz - r, pcz + r)) {
      luzes.add(_Luz(l.$1.toDouble(), l.$2.toDouble(), l.$3.toDouble(), l.$4));
      if (luzes.length >= 32) break;
    }

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

          final lp = _luzPontual(bx.toDouble(), by.toDouble(), bz.toDouble(), luzes);
          final corTopo = _aplicarLuz2(bloco.corTopo, by, bloco.emiteLuz, lp);
          final corEsq = _aplicarLuz2(bloco.corEsquerda, by, bloco.emiteLuz, lp);
          final corDir = _aplicarLuz2(bloco.corDireita, by, bloco.emiteLuz, lp);

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
    if (blocoMao != null) _desenharMao(canvas, tela, blocoMao);
    _desenharMirinha(canvas, tela);
  }

  /// Combina luz ambiente (luzDia, atenuada por profundidade) com luz
  /// pontual local (emitida por blocos próximos). Usa o máximo das duas
  /// fontes — assim uma tocha pode iluminar uma caverna mesmo de noite.
  Color _aplicarLuz2(Color c, int y, bool emite, double pontual) {
    if (emite) return c;
    double ambiente = 0.35 + 0.65 * luzDia;
    if (y < 5) ambiente *= 0.85;
    final fp = 0.35 + 0.65 * pontual.clamp(0.0, 1.0);
    final f = ambiente > fp ? ambiente : fp;
    return Color.fromARGB(
      c.alpha,
      (c.red * f).clamp(0, 255).toInt(),
      (c.green * f).clamp(0, 255).toInt(),
      (c.blue * f).clamp(0, 255).toInt(),
    );
  }

  /// Calcula contribuição de luz pontual (0..1) das luzes próximas para
  /// um bloco. Decaimento quadrático na distância.
  double _luzPontual(double bx, double by, double bz, List<_Luz> luzes) {
    if (luzes.isEmpty) return 0.0;
    double melhor = 0.0;
    for (final l in luzes) {
      final dx = bx - l.x;
      final dy = by - l.y;
      final dz = bz - l.z;
      final d2 = dx * dx + dy * dy + dz * dz;
      final raio = l.nivel.toDouble();
      final raio2 = raio * raio;
      if (d2 >= raio2) continue;
      final cont = 1.0 - d2 / raio2;
      if (cont > melhor) melhor = cont;
    }
    return melhor;
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
    // Gradient do céu interpola entre cores de dia e noite conforme luzDia.
    final cTopoDia = const Color(0xFF1E88E5);
    final cBaseDia = const Color(0xFF87CEEB);
    final cTopoCrep = const Color(0xFFFF8A65); // crepúsculo laranja
    final cBaseCrep = const Color(0xFFFFCC80);
    final cTopoNoite = const Color(0xFF0B1430);
    final cBaseNoite = const Color(0xFF1A2147);

    final t = luzDia.clamp(0.0, 1.0);
    Color cTopo, cBase;
    if (t < 0.35) {
      // noite → crepúsculo
      final k = (t / 0.35).clamp(0.0, 1.0);
      cTopo = Color.lerp(cTopoNoite, cTopoCrep, k)!;
      cBase = Color.lerp(cBaseNoite, cBaseCrep, k)!;
    } else if (t < 0.6) {
      // crepúsculo → dia
      final k = ((t - 0.35) / 0.25).clamp(0.0, 1.0);
      cTopo = Color.lerp(cTopoCrep, cTopoDia, k)!;
      cBase = Color.lerp(cBaseCrep, cBaseDia, k)!;
    } else {
      cTopo = cTopoDia;
      cBase = cBaseDia;
    }

    final rect = Rect.fromLTWH(0, 0, tela.x, tela.y);
    final shader = Gradient.linear(
      Offset(rect.center.dx, rect.top),
      Offset(rect.center.dx, rect.bottom),
      [cTopo, cBase],
    );
    canvas.drawRect(rect, Paint()..shader = shader);

    // === Sol e lua === acompanham tempoDia, com posição em arco visível.
    // Mapeamento: tempoDia=0.25 (meio-dia) → sol no topo. tempoDia=0.75
    // (meia-noite) → lua no topo. Em outros momentos eles entram/saem
    // pelo horizonte.
    final solAng = (tempoDia - 0.25) * 2 * math.pi; // -π/2 nascendo, 0 zênite, π/2 poente
    final solX = tela.x * 0.5 + math.sin(solAng) * tela.x * 0.45;
    final solY = tela.y * 0.35 - math.cos(solAng) * tela.y * 0.32;
    if (solY < tela.y * 0.55) {
      // Halo amarelo
      final halo = Paint()
        ..color = const Color(0x33FFEB3B)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
      canvas.drawCircle(Offset(solX, solY), 50, halo);
      // Disco do sol
      canvas.drawCircle(
        Offset(solX, solY),
        24,
        Paint()..color = const Color(0xFFFFEE58),
      );
      canvas.drawCircle(
        Offset(solX, solY),
        18,
        Paint()..color = const Color(0xFFFFF59D),
      );
    }

    final luaAng = solAng + math.pi;
    final luaX = tela.x * 0.5 + math.sin(luaAng) * tela.x * 0.45;
    final luaY = tela.y * 0.35 - math.cos(luaAng) * tela.y * 0.32;
    if (luaY < tela.y * 0.55) {
      // Halo azulado
      final halo = Paint()
        ..color = const Color(0x33B3E5FC)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawCircle(Offset(luaX, luaY), 40, halo);
      canvas.drawCircle(
        Offset(luaX, luaY),
        20,
        Paint()..color = const Color(0xFFECEFF1),
      );
      // Crateras
      final cra = Paint()..color = const Color(0xFFB0BEC5);
      canvas.drawCircle(Offset(luaX - 6, luaY - 4), 3, cra);
      canvas.drawCircle(Offset(luaX + 5, luaY + 3), 2, cra);
      canvas.drawCircle(Offset(luaX + 2, luaY - 6), 1.5, cra);
    }

    // === Estrelas (apenas à noite) ===
    if (t < 0.45) {
      final alphaEstrela = ((1.0 - t / 0.45) * 220).clamp(0, 255).toInt();
      final starPaint = Paint()
        ..color = Color.fromARGB(alphaEstrela, 255, 255, 230);
      for (int i = 0; i < 60; i++) {
        final sx = (i * 137 % tela.x.toInt()).toDouble();
        final sy = (i * 71 % (tela.y.toInt() ~/ 2)).toDouble();
        // pisca leve
        final twinkle = 0.7 + 0.3 * math.sin(tempoAnim * 2 + i * 0.4);
        canvas.drawCircle(Offset(sx, sy),
            (1.0 + (i % 3) * 0.4) * twinkle, starPaint);
      }
    }

    // === Nuvens em movimento (visíveis de dia) ===
    if (t > 0.4) {
      final alphaNuvem = ((t - 0.4) / 0.6 * 220).clamp(0, 255).toInt();
      final cloudPaint = Paint()..color = Color.fromARGB(alphaNuvem, 255, 255, 255);
      for (int i = 0; i < 7; i++) {
        // Cada nuvem tem deslocamento próprio em x; wrap pelo tela.
        final base = (i * 0.18 + 0.1) * tela.x;
        final speed = 8.0 + (i % 3) * 4.0;
        final x = (base + tempoAnim * speed) % (tela.x + 200) - 100;
        final y = tela.y * (0.10 + (i % 4) * 0.04);
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x, y), width: 80, height: 22),
          cloudPaint,
        );
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x + 25, y - 8), width: 56, height: 18),
          cloudPaint,
        );
        canvas.drawOval(
          Rect.fromCenter(center: Offset(x - 22, y + 4), width: 48, height: 16),
          cloudPaint,
        );
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
