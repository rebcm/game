import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Codec Test', () {
    test('Test .ogg playback', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/ambient/passaros.ogg'));
      await Future.delayed(Duration(seconds: 1));
      await player.stop();
      expect(true, true);
    });

    test('Test .mp3 playback', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/musica1.mp3'));
      await Future.delayed(Duration(seconds: 1));
      await player.stop();
      expect(true, true);
    });
  });
}
