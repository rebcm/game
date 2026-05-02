import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/jogo/gameplay_fisica_integracao.dart';

class RenderizadorIsometrico extends FlameGame {
  late GameplayFisicaIntegracao _gameplayFisicaIntegracao;

  @override
  Future<void> onLoad() async {
    _gameplayFisicaIntegracao = GameplayFisicaIntegracao(ColisaoHandler(), Rebeca());
  }

  @override
  void update(double dt) {
    _gameplayFisicaIntegracao.atualizar();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // Lógica de renderização existente
  }
}
