import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate player state integration with audio service', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('Shuffle'), findsOneWidget);
    expect(find.text('Loop'), findsOneWidget);

    // Test shuffle mode
    await tester.tap(find.text('Shuffle'));
    await tester.pumpAndSettle();
    // Verify UI update after shuffle
    expect(find.text('Shuffle Active'), findsOneWidget);

    // Test loop mode
    await tester.tap(find.text('Loop'));
    await tester.pumpAndSettle();
    // Verify UI update after loop
    expect(find.text('Loop Active'), findsOneWidget);

    // Verify audio service sync
    final AudioPlayer audioPlayer = AudioPlayer();
    final currentMode = await audioPlayer.getCurrentMode();
    expect(currentMode, 'loop'); // Assuming 'loop' is the expected mode after test
  });
}
