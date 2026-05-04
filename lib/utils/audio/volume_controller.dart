import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class VolumeController {
  static final VolumeController _instance = VolumeController._();
  static VolumeController get instance => _instance;

  final AudioPlayer _audioPlayer = AudioPlayer();

  double get currentVolume => _audioPlayer.volume;
  bool get isMuted => _audioPlayer.volume == 0.0;

  VolumeController._();

  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }

  void toggleMute() {
    if (isMuted) {
      setVolume(0.5); // Default volume
    } else {
      setVolume(0.0);
    }
  }
}
