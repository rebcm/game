import 'package:flame/game.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/audio/gerenciador_audio.dart';

class RenderizadorIsometrico extends FlameGame {
  @override
  Future<void> onLoad() async {
    await GeradorMundo.inicializar();
    await GerenciadorAudio.carregarAudio('assets/audio/optimized/sfx/place_block.mp3');
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Lógica de renderização existente
  }

  void tocarSomColocacaoBloco() async {
    await GerenciadorAudio.tocarAudio('assets/audio/optimized/sfx/place_block.mp3');
  }
}
