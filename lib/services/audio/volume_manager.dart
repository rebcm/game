import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class VolumeManager {
  final AudioPlayer _audioPlayer;

  VolumeManager(this._audioPlayer) {
    _initVolumeListener();
  }

  void _initVolumeListener() async {
    try {
      await _audioPlayer.setVolume(1.0); // Initialize volume to maximum
      SystemChannels.platform.invokeMethod('SystemVolume.get'); // Get initial system volume
      SystemChannels.platform.invokeListMethod('SystemVolume.set'); // Listen for system volume changes
      SystemChannels.platform.setMethodCallHandler((call) async {
        if (call.method == 'SystemVolume.set') {
          final systemVolume = call.arguments['volume'];
          if (systemVolume != null) {
            await _audioPlayer.setVolume(systemVolume);
          }
        }
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to initialize volume listener: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
    } on PlatformException catch (e) {
      debugPrint('Failed to set volume: $e');
    }
  }

  Future<double> getVolume() async {
    try {
      return await _audioPlayer.getVolume() ?? 1.0;
    } on PlatformException catch (e) {
      debugPrint('Failed to get volume: $e');
      return 1.0;
    }
  }
}
