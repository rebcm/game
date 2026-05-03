import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioCacheManager', () {
    late AudioCacheManager _audioCacheManager;
    late AudioPlayer _audioPlayer;

    setUp(() {
      _audioPlayer = AudioPlayer();
      _audioCacheManager = AudioCacheManager(_audioPlayer);
    });

    test('preloadAudio caches audio asset', () async {
      final assetPath = 'assets/audio/optimized/sfx/break_block.mp3';
      await _audioCacheManager.preloadAudio(assetPath);
      // Verify caching logic here
    });

    test('playCachedAudio plays cached audio', () async {
      final assetPath = 'assets/audio/optimized/sfx/break_block.mp3';
      await _audioCacheManager.preloadAudio(assetPath);
      await _audioCacheManager.playCachedAudio(assetPath);
      // Verify playback logic here
    });

    tearDown(() {
      _audioCacheManager.dispose();
    });
  });
}
