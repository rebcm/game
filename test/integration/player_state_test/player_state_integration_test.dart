import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Player State Integration Test', () {
    testWidgets('shuffle/loop music updates UI correctly', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assume there's a button to toggle shuffle/loop
      final shuffleButton = find.byKey(const Key('shuffle_button'));
      await tester.tap(shuffleButton);
      await tester.pumpAndSettle();

      // Verify UI update
      expect(find.text('Shuffle is on'), findsOneWidget);

      // Assume there's a service to check audio state
      final audioPlayer = AudioPlayer();
      final currentState = await audioPlayer.getCurrentState();
      expect(currentState, isNotNull);
    });

    testWidgets('loop music updates UI correctly', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Assume there's a button to toggle loop
      final loopButton = find.byKey(const Key('loop_button'));
      await tester.tap(loopButton);
      await tester.pumpAndSettle();

      // Verify UI update
      expect(find.text('Loop is on'), findsOneWidget);

      // Assume there's a service to check audio state
      final audioPlayer = AudioPlayer();
      final currentState = await audioPlayer.getCurrentState();
      expect(currentState, isNotNull);
    });
  });
}
