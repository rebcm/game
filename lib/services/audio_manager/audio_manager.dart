import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._();
  final AudioPlayer _audioPlayer = AudioPlayer();

  factory AudioManager() => _instance;

  AudioManager._();

  void play(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    _audioPlayer.play();
  }

  void stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
