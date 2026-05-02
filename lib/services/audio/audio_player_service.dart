import 'package:rebcm/services/audio/audio_manager.dart';

class AudioPlayerService {
  final AudioManager _audioManager = AudioManager();

  Future<void> init() async {
    await _audioManager.init();
  }

  Future<void> playAmbient(String assetPath) async {
    await _audioManager.playAmbient(assetPath);
  }

  Future<void> playEffect(String assetPath) async {
    await _audioManager.playEffect(assetPath);
  }

  Future<void> playMusic(String assetPath) async {
    await _audioManager.playMusic(assetPath);
  }

  void stopAmbient() {
    _audioManager.stopAmbient();
  }

  void stopEffect() {
    _audioManager.stopEffect();
  }

  void stopMusic() {
    _audioManager.stopMusic();
  }
}
