import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolumeControlsProvider with ChangeNotifier {
  double _masterVolume = 1.0;
  double _musicVolume = 1.0;
  double _effectsVolume = 1.0;

  double get masterVolume => _masterVolume;
  double get musicVolume => _musicVolume;
  double get effectsVolume => _effectsVolume;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _masterVolume = prefs.getDouble('masterVolume') ?? 1.0;
    _musicVolume = prefs.getDouble('musicVolume') ?? 1.0;
    _effectsVolume = prefs.getDouble('effectsVolume') ?? 1.0;
    notifyListeners();
  }

  Future<void> setMasterVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('masterVolume', volume);
    _masterVolume = volume;
    notifyListeners();
  }

  Future<void> setMusicVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('musicVolume', volume);
    _musicVolume = volume;
    notifyListeners();
  }

  Future<void> setEffectsVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('effectsVolume', volume);
    _effectsVolume = volume;
    notifyListeners();
  }
}
