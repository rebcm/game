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
  _Quad(this.path, this.color, this.sortKey);
}

class RenderizadorIsometrico {
  void render(Canvas canvas, Mundo mundo, Rebeca rebeca, Vector2 tamanhoTela) {
    final cx = tamanhoTela.x / 2 - rebeca.telaX;
    final cy = tamanhoTela.y / 2 - rebeca.telaY;
    final quads = <_Quad>[];

    for (int bx = 0; bx < mundo.largura; bx++) {
      for (int bz = 0; bz < mundo.profundidade; bz++) {
        for (int by = 0; by < mundo.altura; by++) {
          final bloco = mundo.get(bx, by, bz);
          if (!bloco.solido) continue;
          final sx = cx + (bx - bz) * Constantes.halfW;
          final sy = cy + (bx + bz) * Constantes.halfH - by * Constantes.sideH;
          final topoVisivel = !mundo.isSolido(bx, by + 1, bz);
          final esquerdaVisivel = !mundo.isSolido(bx - 1, by, bz);
          final direitaVisivel = !mundo.isSolido(bx, by, bz - 1);
          if (!topoVisivel && !esquerdaVisivel && !direitaVisivel) continue;
          final double sk = (bx + bz) * 1000.0 + by.toDouble();
          if (topoVisivel) quads.add(_buildTop(sx, sy, bloco.corTopo, sk));
          if (esquerdaVisivel) quads.add(_buildLeft(sx, sy, bloco.corEsquerda, sk - 0.1));
          if (direitaVisivel) quads.add(_buildRight(sx, sy, bloco.corDireita, sk - 0.2));
        }
      }
    }

    quads.sort((a, b) => a.sortKey.compareTo(b.sortKey));
    final fill = Paint()..style = PaintingStyle.fill;
    final stroke = Paint()..style = PaintingStyle.stroke..strokeWidth = 0.5..color = const Color(0x33000000);
    for (final q in quads) {
      fill.color = q.color;
      canvas.drawPath(q.path, fill);
      canvas.drawPath(q.path, stroke);
    }
    _desenharRebeca(canvas, cx, cy, rebeca);
  }

  _Quad _buildTop(double sx, double sy, Color color, double sk) {
    final p = Path()
      ..moveTo(sx, sy - Constantes.halfH)..lineTo(sx + Constantes.halfW, sy)
      ..lineTo(sx, sy + Constantes.halfH)..lineTo(sx - Constantes.halfW, sy)..close();
    return _Quad(p, color, sk);
  }

  _Quad _buildLeft(double sx, double sy, Color color, double sk) {
    final p = Path()
      ..moveTo(sx - Constantes.halfW, sy)..lineTo(sx, sy + Constantes.halfH)
      ..lineTo(sx, sy + Constantes.halfH + Constantes.sideH)
      ..lineTo(sx - Constantes.halfW, sy + Constantes.sideH)..close();
    return _Quad(p, color, sk);
  }

  _Quad _buildRight(double sx, double sy, Color color, double sk) {
    final p = Path()
      ..moveTo(sx, sy + Constantes.halfH)..lineTo(sx + Constantes.halfW, sy)
      ..lineTo(sx + Constantes.halfW, sy + Constantes.sideH)
      ..lineTo(sx, sy + Constantes.halfH + Constantes.sideH)..close();
    return _Quad(p, color, sk);
  }

  void _desenharRebeca(Canvas canvas, double cx, double cy, Rebeca rebeca) {
    final sx = cx + rebeca.telaX;
    final sy = cy + rebeca.telaY;
    final fill = Paint()..color = const Color(0xFFE91E63)..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(sx, sy - 14)..lineTo(sx + 10, sy)
      ..lineTo(sx, sy + 14)..lineTo(sx - 10, sy)..close();
    canvas.drawPath(path, fill);
    fill..color = const Color(0xFFFFFFFF)..style = PaintingStyle.stroke..strokeWidth = 1.5;
    canvas.drawPath(path, fill);
  }
}
