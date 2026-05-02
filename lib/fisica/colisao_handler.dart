import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/personagem/rebeca.dart';

class ColisaoHandler {
  void handleColisao(Rebeca rebeca, TipoBloco tipoBloco, Vector2 posicao) {
    if (tipoBloco == TipoBloco.VAZIO) return;

    if (rebeca.posicao.y > posicao.y && rebeca.velocidade.y > 0) {
      rebeca.posicao.y = posicao.y - rebeca.tamanho.y;
      rebeca.velocidade.y = 0;
      rebeca.estaNoChao = true;
    }
  }

  void handleQueda(Rebeca rebeca, double alturaMinima) {
    if (rebeca.posicao.y > alturaMinima) {
      // Implementar lógica de queda do mapa
      print('Rebeca caiu do mapa!');
    }
  }
}
