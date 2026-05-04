import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager with ChangeNotifier {
  double _volume = 1.0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  double get volume => _volume;

  void setVolume(double volume) {
    _volume = volume;
    _audioPlayer.setVolume(volume);
    notifyListeners();
  }

  void playAudio(String path) async {
    await _audioPlayer.play(AssetSource(path));
  }

  void stopAudio() async {
    await _audioPlayer.stop();
  }
}
