import 'package:flutter/material.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider with ChangeNotifier {
  late AudioCacheManager _audioCacheManager;
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioProvider() {
    _audioCacheManager = AudioCacheManager(_audioPlayer);
    _preloadAudioAssets();
  }

  Future<void> _preloadAudioAssets() async {
    final List<String> audioAssets = [
      'assets/audio/optimized/sfx/break_block.mp3',
      // Add other necessary audio assets here
    ];
    for (var asset in audioAssets) {
      await _audioCacheManager.preloadAudio(asset);
    }
  }

  Future<void> playAudio(String assetPath) async {
    await _audioCacheManager.playCachedAudio(assetPath);
  }

  @override
  void dispose() {
    _audioCacheManager.dispose();
    super.dispose();
  }
}
