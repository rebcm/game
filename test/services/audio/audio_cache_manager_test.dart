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

    test('loads and plays cached asset', () async {
      await _audioCacheManager.loadAsset('assets/audio/optimized/sfx/test.mp3');
      await _audioCacheManager.playCachedAsset('assets/audio/optimized/sfx/test.mp3');
      expect(_audioPlayer.playing, true);
    });
  });
}
