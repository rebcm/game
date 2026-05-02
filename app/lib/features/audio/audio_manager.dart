import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playMusic(String assetPath, {bool loop = false}) async {
    await _audioPlayer.play(AssetSource(assetPath), loop: loop);
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
  }
}
