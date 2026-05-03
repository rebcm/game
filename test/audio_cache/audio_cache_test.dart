import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio_cache/audio_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  test('Audio cache is cleared', () async {
    final audioPlayer = AudioPlayer();
    final audioCacheManager = AudioCacheManager(audioPlayer);
    audioCacheManager.clearCache();
    expect(audioPlayer.playerState, null);
  });
}
