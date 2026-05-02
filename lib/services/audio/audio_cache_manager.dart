import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AudioCacheManager {
  final AudioPlayer _audioPlayer;
  final Map<String, ByteData> _cache = {};

  AudioCacheManager(this._audioPlayer);

  Future<void> loadAsset(String assetPath) async {
    if (!_cache.containsKey(assetPath)) {
      final ByteData data = await rootBundle.load(assetPath);
      _cache[assetPath] = data;
    }
  }

  Future<void> playCachedAsset(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      await _audioPlayer.setAudioSource(
        ByteDataSource(_cache[assetPath]!.buffer.asUint8List()),
      );
      await _audioPlayer.play();
    } else {
      await loadAsset(assetPath);
      await playCachedAsset(assetPath);
    }
  }
}

class ByteDataSource extends StreamAudioSource {
  final List<int> bytes;

  ByteDataSource(this.bytes) : super(tag: 'ByteDataSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
