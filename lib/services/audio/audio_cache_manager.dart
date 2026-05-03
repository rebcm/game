import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class AudioCacheManager {
  static final AudioCacheManager _instance = AudioCacheManager._internal();
  final Map<String, Uint8List> _audioCache = {};

  factory AudioCacheManager() => _instance;

  AudioCacheManager._internal();

  Future<void> preloadAudioAssets(List<String> assetPaths) async {
    for (var path in assetPaths) {
      if (!_audioCache.containsKey(path)) {
        final ByteData data = await rootBundle.load(path);
        _audioCache[path] = data.buffer.asUint8List();
      }
    }
  }

  Future<AudioPlayer> getAudioPlayer(String assetPath) async {
    if (!_audioCache.containsKey(assetPath)) {
      await preloadAudioAssets([assetPath]);
    }
    final player = AudioPlayer();
    await player.setAudioData(_audioCache[assetPath]!, preload: true);
    return player;
  }
}
