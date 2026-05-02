import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Codec Compatibility Test', () {
    test('should play .ogg file without errors', () async {
      final player = AudioPlayer();
      await player.setAsset('assets/audio/optimized/ambient/test.ogg');
      await player.play();
      await Future.delayed(const Duration(seconds: 2));
      await player.stop();
      expect(player.playing, false);
    });

    test('should play .mp3 file without errors', () async {
      final player = AudioPlayer();
      await player.setAsset('assets/audio/optimized/music/test.mp3');
      await player.play();
      await Future.delayed(const Duration(seconds: 2));
      await player.stop();
      expect(player.playing, false);
    });
  });
}
