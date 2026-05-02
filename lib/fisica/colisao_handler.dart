import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';

class ColisaoHandler {
  void handleColisao(Vector2 posicao, TipoBloco tipoBloco) {
    if (tipoBloco == TipoBloco.VAZIO) return;

    // Lógica para lidar com colisões
    // Exemplo: detectar queda do mapa
    if (posicao.y > GeradorMundo.alturaMaxima) {
      // Trigger evento de queda do mapa
      print("Queda do mapa detectada!");
    }
  }
}
