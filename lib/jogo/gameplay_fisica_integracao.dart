import 'package:flame/game.dart';
import 'package:rebcm/fisica/colisao_handler.dart';
import 'package:rebcm/personagem/rebeca.dart';

class GameplayFisicaIntegracao {
  final ColisaoHandler _colisaoHandler;
  final Rebeca _rebeca;

  GameplayFisicaIntegracao(this._colisaoHandler, this._rebeca);

  void atualizar() {
    // Verificar colisões e aplicar lógica de gameplay
    _colisaoHandler.handleColisao(_rebeca.posicao, _rebeca.tipoBlocoColidido);
  }
}
