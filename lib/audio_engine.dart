import 'package:audioplayers/audioplayers.dart';

class AudioEngine {
  final AudioPlayer _audioPlayer;

  AudioEngine(this._audioPlayer);

  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }
}
