import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_cache/audio_cache_service.dart';

void main() {
  group('AudioCacheService', () {
    late AudioCacheService audioCacheService;

    setUp(() {
      audioCacheService = AudioCacheService();
    });

    test('disposeAudio disposes audio player', () {
      audioCacheService.loadAudio('assets/audio/optimized/ambient/sound.mp3');
      audioCacheService.disposeAudio();
      expect(() async => await audioCacheService._audioPlayer.play(), throwsA(isA<StateError>()));
    });

    test('dispose calls disposeAudio', () {
      audioCacheService.loadAudio('assets/audio/optimized/ambient/sound.mp3');
      audioCacheService.dispose();
      expect(() async => await audioCacheService._audioPlayer.play(), throwsA(isA<StateError>()));
    });
  });
}
