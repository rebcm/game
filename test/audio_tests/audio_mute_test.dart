import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Mute functionality test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test mute button functionality
    final muteButton = find.byTooltip('Mute');
    await tester.tap(muteButton);
    await tester.pumpAndSettle();

    // Verify audio is muted
    // Implementation depends on how audio is handled in the app
    // For example, if using just_audio, you might check the player state
  });

  testWidgets('Mute functionality test in background', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Put the app in background
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pumpAndSettle();

    // Test mute button functionality while app is in background
    final muteButton = find.byTooltip('Mute');
    await tester.tap(muteButton);
    await tester.pumpAndSettle();

    // Verify audio is muted while app is in background
    // Implementation depends on how audio is handled in the app
  });
}
