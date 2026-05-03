import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_cache_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioCacheManager', () {
    late AudioPlayer _audioPlayer;
    late AudioCacheManager _audioCacheManager;

    setUp(() {
      _audioPlayer = AudioPlayer();
      _audioCacheManager = AudioCacheManager(_audioPlayer);
    });

    tearDown(() {
      _audioCacheManager.dispose();
      _audioPlayer.dispose();
    });

    test('preload and play audio', () async {
      const assetPath = 'assets/audio/optimized/sfx/block_break.mp3';
      await _audioCacheManager.preloadAudio(assetPath);
      await _audioCacheManager.playCachedAudio(assetPath);
      expect(_audioPlayer.playing, true);
    });
  });
}
