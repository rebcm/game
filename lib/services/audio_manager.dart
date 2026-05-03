import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager with ChangeNotifier {
  bool _isOutputSpeaker = true;
  double _volume = 0.5;

  bool get isOutputSpeaker => _isOutputSpeaker;
  double get volume => _volume;

  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() => _instance;

  AudioManager._internal();

  static AudioManager get instance => _instance;

  void toggleOutput() {
    _isOutputSpeaker = !_isOutputSpeaker;
    notifyListeners();
  }

  void setVolume(double volume) {
    _volume = volume;
    notifyListeners();
  }
}
