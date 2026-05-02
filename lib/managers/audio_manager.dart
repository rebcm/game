import 'package:rebcm/services/audio/audio_service.dart';

class AudioManager {
  final AudioService _audioService = AudioService();

  Future<void> playMusic(String assetPath) async {
    await _audioService.stop();
    await _audioService.setLoopMode(true);
    await _audioService.play(assetPath);
  }

  Future<void> stopMusic() async {
    await _audioService.stop();
  }

  Future<void> playSfx(String assetPath) async {
    await _audioService.stop();
    await _audioService.setLoopMode(false);
    await _audioService.play(assetPath);
  }
}
