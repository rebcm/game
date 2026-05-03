import 'package:flutter/material.dart';
import 'package:rebcm/services/audio_manager/volume_guard.dart';

class AudioProvider with ChangeNotifier {
  final VolumeGuard _volumeGuard = VolumeGuard();

  double _globalVolume = 1.0;

  double get globalVolume => _globalVolume;

  void updateGlobalVolume(double volume) {
    if (_volumeGuard.isUpdating) return;
    _globalVolume = volume;
    notifyListeners();
  }

  void updateIndividualVolume(double volume) {
    _volumeGuard.updateVolume(volume);
    // Logic to update individual volume
  }
}
