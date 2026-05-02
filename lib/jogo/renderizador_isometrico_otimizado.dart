import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:rebcm/mundo/gerador.dart';

class RenderizadorIsometricoOtimizado {
  void renderizarChunk(Canvas canvas, Chunk chunk) {
    final paint = Paint();
    final listaBlocos = chunk.blocos;

    for (var z = 0; z < Constantes.chunkTamanho; z++) {
      for (var x = 0; x < Constantes.chunkTamanho; x++) {
        for (var y = 0; y < Constantes.chunkAltura; y++) {
          final bloco = listaBlocos[x][y][z];
          if (bloco != TipoBloco.ar) {
            final screenX = (x - z) * (Constantes.tamanhoBloco / 2);
            final screenY = (x + z) * (Constantes.tamanhoBloco / 4) - y * (Constantes.tamanhoBloco / 2);

            paint.color = bloco.cor;
            canvas.drawPath(_getBlocoPath(screenX, screenY, Constantes.tamanhoBloco), paint);
          }
        }
      }
    }
  }

  Path _getBlocoPath(double screenX, double screenY, double tamanho) {
    final path = Path();
    // Desenhar as 3 faces do bloco isometricamente
    path.moveTo(screenX, screenY);
    path.lineTo(screenX + tamanho / 2, screenY + tamanho / 4);
    path.lineTo(screenX, screenY + tamanho / 2);
    path.lineTo(screenX - tamanho / 2, screenY + tamanho / 4);
    path.close();

    path.moveTo(screenX, screenY);
    path.lineTo(screenX + tamanho / 2, screenY + tamanho / 4);
    path.lineTo(screenX + tamanho / 2, screenY + tamanho / 4 + tamanho / 2);
    path.lineTo(screenX, screenY + tamanho / 2);
    path.close();

    path.moveTo(screenX, screenY);
    path.lineTo(screenX - tamanho / 2, screenY + tamanho / 4);
    path.lineTo(screenX - tamanho / 2, screenY + tamanho / 4 + tamanho / 2);
    path.lineTo(screenX, screenY + tamanho / 2);
    path.close();

    return path;
  }
}
