import Intl.message('package:flutter/material.dart');

class SoundSettingsProvider with ChangeNotifier {
  double _volume = 1.0;
  bool _isMuted = false;

  double get volume => _volume;
  bool get isMuted => _isMuted;

  void setVolume(double volume) {
    _volume = volume;
    notifyListeners();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    notifyListeners();
  }
}
