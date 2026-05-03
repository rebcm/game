import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

void main() {
  group('AudioCacheManager', () {
    late AudioPlayer _audioPlayer;
    late AudioCacheManager _audioCacheManager;

    setUp(() {
      _audioPlayer = AudioPlayer();
      _audioCacheManager = AudioCacheManager(_audioPlayer);
    });

    tearDown(() {
      _audioCacheManager.dispose();
    });

    test('loads and plays cached asset', () async {
      const String assetPath = 'assets/audio/optimized/sfx/placeholder_sfx.mp3';
      await _audioCacheManager.loadAsset(assetPath);
      await _audioCacheManager.playCachedAsset(assetPath);
      expect(_audioPlayer.playing, true);
    });
  });
}
