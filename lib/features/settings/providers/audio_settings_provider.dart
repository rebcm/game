import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioSettingsProvider with ChangeNotifier {
  bool _musicEnabled = true;
  double _musicVolume = 1.0;
  bool _sfxEnabled = true;
  double _sfxVolume = 1.0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool get musicEnabled => _musicEnabled;
  double get musicVolume => _musicVolume;
  bool get sfxEnabled => _sfxEnabled;
  double get sfxVolume => _sfxVolume;

  void toggleMusic() {
    _musicEnabled = !_musicEnabled;
    _audioPlayer.setEnabled(_musicEnabled);
    notifyListeners();
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume;
    _audioPlayer.setVolume(_musicVolume);
    notifyListeners();
  }

  void toggleSFX() {
    _sfxEnabled = !_sfxEnabled;
    notifyListeners();
  }

  void setSFXVolume(double volume) {
    _sfxVolume = volume;
    notifyListeners();
  }
}
