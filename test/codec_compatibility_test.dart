import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Codec Compatibility Test', () {
    test('Play .ogg files', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/optimized/ambient/test.ogg'));
      await Future.delayed(Duration(seconds: 2));
      await player.stop();
    });

    test('Play .mp3 files', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/optimized/ambient/test.mp3'));
      await Future.delayed(Duration(seconds: 2));
      await player.stop();
    });
  });
}
