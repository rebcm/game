import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

void main() {
  group('AudioCacheManager', () {
    late AudioPlayer audioPlayer;
    late AudioCacheManager cacheManager;

    setUp(() {
      audioPlayer = AudioPlayer();
      cacheManager = AudioCacheManager(audioPlayer);
    });

    test('loads and plays cached asset', () async {
      const assetPath = 'assets/audio/optimized/sfx/sound.mp3';
      await cacheManager.loadAsset(assetPath);
      await cacheManager.playCachedAsset(assetPath);
      expect(audioPlayer.playing, true);
    });
  });
}
