import 'package:audioplayers/audioplayers.dart';

class AudioPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void play(String url) {
    _audioPlayer.play(AssetSource(url));
  }

  void interrupt() {
    _audioPlayer.pause();
  }

  void resume() {
    _audioPlayer.resume();
  }

  bool get isPlaying => _audioPlayer.state == PlayerState.playing;
}
