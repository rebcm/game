import 'package:flame/game.dart';
import 'package:rebcm/fisica/colisao_handler.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/mundo/gerador.dart';

class IntegracaoFisicaGameplay {
  final ColisaoHandler _colisaoHandler;
  final Rebeca _rebeca;
  final GeradorMundo _geradorMundo;

  IntegracaoFisicaGameplay(this._colisaoHandler, this._rebeca, this._geradorMundo);

  void atualizar() {
    // Verificar colisões e aplicar lógica de gameplay
    _geradorMundo.mundo.forEach((posicao, tipoBloco) {
      _colisaoHandler.handleColisao(_rebeca, tipoBloco, posicao);
    });

    _colisaoHandler.handleQueda(_rebeca, _geradorMundo.alturaMinima);
  }
}
