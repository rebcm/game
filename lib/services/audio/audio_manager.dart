import 'package:audioplayers/audioplayers.dart';
import 'package:audio_service/audio_service.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String assetPath) async {
    await _audioPlayer.play(AssetSource(assetPath));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }
}
