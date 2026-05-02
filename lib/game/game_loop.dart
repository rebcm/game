import 'package:flame/game.dart';
import 'package:rebcm/services/audio/audio_manager.dart';

class GameLoop extends FlameGame {
  final AudioManager _audioManager = AudioManager();

  @override
  Future<void> onLoad() async {
    await _audioManager.initAudio();
    _audioManager.playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Game loop logic here
  }
}
