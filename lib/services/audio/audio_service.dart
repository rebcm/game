import 'package:audio_service/audio_service.dart';
import 'package:rebcm/services/audio/audio_manager.dart';

class AudioService {
  final AudioManager _audioManager = AudioManager();

  Future<void> playAudio(String assetPath) async {
    await _audioManager.playAudio(assetPath);
  }

  Future<void> stopAudio() async {
    await _audioManager.stopAudio();
  }

  Future<void> setVolume(double volume) async {
    await _audioManager.setVolume(volume);
  }
}
