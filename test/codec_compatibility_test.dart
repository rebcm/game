import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Codec Compatibility Test', () {
    test('plays ogg file', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/optimized/sfx/click.ogg'));
      await Future.delayed(Duration(seconds: 1));
      await player.stop();
    });

    test('plays mp3 file', () async {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/optimized/music/theme.mp3'));
      await Future.delayed(Duration(seconds: 1));
      await player.stop();
    });
  });
}
