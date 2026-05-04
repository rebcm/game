import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer _audioPlayer;

  AudioManager(this._audioPlayer);

  Future<void> playBackgroundMusic() async {
    await _audioPlayer.play(AssetSource('sounds/background.mp3'));
  }

  Future<void> pauseBackgroundMusic() async {
    await _audioPlayer.pause();
  }

  Future<void> setSilentMode(bool silent) async {
    if (silent) {
      await _audioPlayer.setVolume(0);
    } else {
      await _audioPlayer.setVolume(1);
    }
  }
}
