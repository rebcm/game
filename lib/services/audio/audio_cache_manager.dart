import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class AudioCacheManager {
  final AudioPlayer _audioPlayer;
  final Map<String, Uint8List> _cache = {};

  AudioCacheManager(this._audioPlayer);

  Future<void> preloadAudio(String assetPath) async {
    if (!_cache.containsKey(assetPath)) {
      final ByteData data = await rootBundle.load(assetPath);
      _cache[assetPath] = data.buffer.asUint8List();
    }
  }

  Future<void> playCachedAudio(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      await _audioPlayer.setAudioSource(
        AudioSource.bytes(_cache[assetPath]!),
      );
      await _audioPlayer.play();
    } else {
      await preloadAudio(assetPath);
      await playCachedAudio(assetPath);
    }
  }

  void dispose() {
    _audioPlayer.dispose();
    _cache.clear();
  }
}
