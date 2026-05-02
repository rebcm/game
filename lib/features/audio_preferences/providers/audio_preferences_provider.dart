import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPreferencesProvider with ChangeNotifier {
  static const String _muteKey = 'mute';
  static const String _volumeKey = 'volume';

  bool _isMuted = false;
  double _volume = 1.0;

  bool get isMuted => _isMuted;
  double get volume => _volume;

  AudioPreferencesProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = prefs.getBool(_muteKey) ?? false;
    _volume = prefs.getDouble(_volumeKey) ?? 1.0;
    notifyListeners();
  }

  Future<void> toggleMute() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = !_isMuted;
    await prefs.setBool(_muteKey, _isMuted);
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    _volume = volume;
    await prefs.setDouble(_volumeKey, _volume);
    notifyListeners();
  }
}
