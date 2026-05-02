import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../audio_transition/audio_transition.dart';

class MusicPlayer with ChangeNotifier {
  double _currentVolume = 1.0;
  final AudioTransition _audioTransition;

  MusicPlayer(this._audioTransition);

  void playNextSong() {
    _audioTransition.interpolateVolume(0.0, Duration(milliseconds: 500));
    // lógica para tocar a próxima música
    _audioTransition.interpolateVolume(1.0, Duration(milliseconds: 500));
  }
}
