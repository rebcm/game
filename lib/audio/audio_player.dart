import 'package:just_audio/just_audio.dart';

class AudioPlayer {
  final _player = AudioPlayer();

  Future<void> play(String assetPath) async {
    await _player.setAsset(assetPath);
    _player.play();
  }
}
