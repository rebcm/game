import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheManager {
  final AudioPlayer _audioPlayer;
  final Map<String, ByteData> _cache;

  AudioCacheManager(this._audioPlayer) : _cache = {};

  Future<void> loadAsset(String assetPath) async {
    if (!_cache.containsKey(assetPath)) {
      final ByteData data = await rootBundle.load(assetPath);
      _cache[assetPath] = data;
    }
  }

  Future<void> playCachedAsset(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      await _audioPlayer.setAudioSource(
        ByteSource(_cache[assetPath]!.buffer.asUint8List()),
      );
      await _audioPlayer.play();
    } else {
      await loadAsset(assetPath);
      await playCachedAsset(assetPath);
    }
  }

  void dispose() {
    _cache.clear();
    _audioPlayer.dispose();
  }
}
