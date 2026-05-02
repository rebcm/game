import 'package:flame/game.dart';
import 'package:rebcm/services/audio/audio_service.dart';

class GameLoopIntegration with Game {
  final AudioServiceImpl _audioService;

  GameLoopIntegration(this._audioService);

  @override
  void update(double dt) {
    // Integrate audio with game loop logic here
    super.update(dt);
  }

  void playAmbient() {
    _audioService.playAmbient('assets/audio/optimized/ambient/default.mp3');
  }
}
