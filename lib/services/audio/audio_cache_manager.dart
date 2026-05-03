import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheManager {
  final AudioPlayer _audioPlayer;
  final Map<String, ByteData> _cache;

  AudioCacheManager(this._audioPlayer) : _cache = {};

  Future<ByteData> _loadAsset(String assetPath) async {
    return await rootBundle.load(assetPath);
  }

  Future<void> preloadAudio(String assetPath) async {
    if (!_cache.containsKey(assetPath)) {
      _cache[assetPath] = await _loadAsset(assetPath);
    }
  }

  Future<void> playCachedAudio(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      await _audioPlayer.setAudioSource(AudioSource.bytes(_cache[assetPath]!.buffer.asUint8List()));
      await _audioPlayer.play();
    } else {
      await preloadAudio(assetPath);
      await playCachedAudio(assetPath);
    }
  }

  void dispose() {
    _cache.clear();
  }
}
