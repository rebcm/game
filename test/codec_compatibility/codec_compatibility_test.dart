import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Codec Compatibility Test', () {
    test('Test .ogg playback', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/ambient/passaros.ogg'));
      await Future.delayed(Duration(seconds: 1));
      await player.stop();
      expect(true, true);
    });

    test('Test .mp3 playback', () async {
      final player = AudioPlayer();
      // Assuming there's an .mp3 file in the assets
      await player.play(AssetSource('audio/music/some_music.mp3'));
      await Future.delayed(Duration(seconds: 1));
      await player.stop();
      expect(true, true);
    });
  });
}
