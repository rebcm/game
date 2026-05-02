import 'package:flame/game.dart';
import 'package:rebcm/services/audio/audio_manager.dart';

class GameLoop extends FlameGame {
  final AudioManager _audioManager = AudioManager();

  @override
  Future<void> onLoad() async {
    await _audioManager.init();
    _audioManager.play();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
