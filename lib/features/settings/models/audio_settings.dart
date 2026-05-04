import 'package:flutter/foundation.dart';

class AudioSettings with ChangeNotifier {
  bool _isMusicMuted = false;
  bool _isSfxMuted = false;
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;

  bool get isMusicMuted => _isMusicMuted;
  bool get isSfxMuted => _isSfxMuted;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  void toggleMusicMute() {
    _isMusicMuted = !_isMusicMuted;
    notifyListeners();
  }

  void toggleSfxMute() {
    _isSfxMuted = !_isSfxMuted;
    notifyListeners();
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume;
    notifyListeners();
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume;
    notifyListeners();
  }
}
