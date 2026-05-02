import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Codec Compatibility Test', () {
    test('Test .ogg playback on Android and iOS', () async {
      final player = AudioPlayer();
      final result = await player.play(AssetSource('assets/audio/optimized/sfx/click.ogg'));
      expect(result, isNotNull);
      await player.stop();
      await player.dispose();
    });

    test('Test .mp3 playback on Android and iOS', () async {
      final player = AudioPlayer();
      final result = await player.play(AssetSource('assets/audio/optimized/sfx/click.mp3'));
      expect(result, isNotNull);
      await player.stop();
      await player.dispose();
    });
  });
}
