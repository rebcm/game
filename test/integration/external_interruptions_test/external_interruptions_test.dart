import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/audio/audio_player.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test audio interruption by phone call', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Start playing audio
    AudioPlayer().play('test_audio.mp3');
    await tester.pumpAndSettle();

    // Simulate phone call interruption
    // Assuming there's a method to simulate this in the audio player or a mock
    AudioPlayer().interrupt();

    // Verify audio state after interruption
    expect(AudioPlayer().isPlaying, false);

    // Resume audio if necessary and verify
    AudioPlayer().resume();
    expect(AudioPlayer().isPlaying, true);
  });

  testWidgets('Test audio interruption by alarm', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Start playing audio
    AudioPlayer().play('test_audio.mp3');
    await tester.pumpAndSettle();

    // Simulate alarm interruption
    AudioPlayer().interrupt();

    // Verify audio state after interruption
    expect(AudioPlayer().isPlaying, false);
  });
}
