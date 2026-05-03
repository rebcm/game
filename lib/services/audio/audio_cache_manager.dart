import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class AudioCacheManager {
  static final AudioCacheManager _instance = AudioCacheManager._internal();
  final Map<String, Uint8List> _audioCache = {};

  factory AudioCacheManager() => _instance;

  AudioCacheManager._internal();

  Future<void> preloadAudio(String assetPath) async {
    if (!_audioCache.containsKey(assetPath)) {
      final ByteData data = await rootBundle.load(assetPath);
      _audioCache[assetPath] = data.buffer.asUint8List();
    }
  }

  Future<AudioPlayer> getAudioPlayer(String assetPath) async {
    await preloadAudio(assetPath);
    final AudioPlayer player = AudioPlayer();
    await player.setAudioData(_audioCache[assetPath]!, start: 0, end: _audioCache[assetPath]!.length);
    return player;
  }
}
