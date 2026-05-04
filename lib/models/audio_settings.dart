import 'package:flutter/material.dart';

class AudioSettings with ChangeNotifier {
  double _volume = 1.0;

  double get volume => _volume;

  void setVolume(double volume) {
    _volume = volume;
    notifyListeners();
  }
}
