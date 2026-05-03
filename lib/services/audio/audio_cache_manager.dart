import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> preloadAudioAssets(List<String> assetPaths) async {
    for (final path in assetPaths) {
      await _audioPlayer.setAsset(path);
    }
  }

  Future<void> playAudio(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    await _audioPlayer.play();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
