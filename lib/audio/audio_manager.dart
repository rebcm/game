import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSound(String assetPath) async {
    await _player.play(AssetSource(assetPath));
  }

  Future<void> stopSound() async {
    await _player.stop();
  }
}
