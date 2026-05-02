import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioTransitionProvider with ChangeNotifier {
  final AudioPlayer _currentPlayer;
  final AudioPlayer _nextPlayer;

  AudioTransitionProvider({
    required AudioPlayer currentPlayer,
    required AudioPlayer nextPlayer,
  })  : _currentPlayer = currentPlayer,
        _nextPlayer = nextPlayer;

  void transition(double value) {
    _currentPlayer.setVolume(1 - value);
    _nextPlayer.setVolume(value);
  }

  void reset() {
    _currentPlayer.setVolume(1);
    _nextPlayer.setVolume(0);
  }
}
