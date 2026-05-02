import 'package:flutter/material.dart';
import 'package:rebcm/services/settings/volume_settings_service.dart';

class VolumeProvider with ChangeNotifier {
  final VolumeSettingsService _volumeSettingsService = VolumeSettingsService();

  double _volume = 1.0;
  bool _mute = false;

  double get volume => _volume;
  bool get mute => _mute;

  VolumeProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _volume = await _volumeSettingsService.getVolume();
    _mute = await _volumeSettingsService.getMute();
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    await _volumeSettingsService.setVolume(volume);
    notifyListeners();
  }

  Future<void> toggleMute() async {
    _mute = !_mute;
    await _volumeSettingsService.setMute(_mute);
    notifyListeners();
  }
}
