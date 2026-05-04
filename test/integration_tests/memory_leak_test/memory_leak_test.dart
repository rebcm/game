import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio player memory leak test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('sounds/short_sound.mp3'));
    await Future.delayed(Duration(seconds: 1));
    await audioPlayer.dispose();

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.byType(AudioPlayer), findsNothing);
  });
}
