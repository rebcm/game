import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioCacheManager', () {
    test('preloadAudio caches audio data', () async {
      final cacheManager = AudioCacheManager();
      final assetPath = 'assets/audio/optimized/sfx/block_break.mp3';
      await cacheManager.preloadAudio(assetPath);
      expect(cacheManager._audioCache.containsKey(assetPath), true);
    });

    test('getAudioPlayer returns an AudioPlayer instance', () async {
      final cacheManager = AudioCacheManager();
      final assetPath = 'assets/audio/optimized/sfx/block_break.mp3';
      final player = await cacheManager.getAudioPlayer(assetPath);
      expect(player, isNotNull);
    });
  });
}
