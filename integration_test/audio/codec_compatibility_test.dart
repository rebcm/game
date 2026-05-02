import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test .ogg playback compatibility', (tester) async {
    final player = AudioPlayer();
    await player.play(AssetSource('audio/ambient/passaros.ogg'));
    await Future.delayed(const Duration(seconds: 1));
    await player.stop();
    expect(await player.getCurrentPosition(), isNotNull);
  });

  testWidgets('Test .mp3 playback compatibility', (tester) async {
    final player = AudioPlayer();
    // Assuming there's an .mp3 file in the assets
    await player.play(AssetSource('audio/music/dia_01.mp3'));
    await Future.delayed(const Duration(seconds: 1));
    await player.stop();
    expect(await player.getCurrentPosition(), isNotNull);
  });
}
