import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test audio interruption', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Start playing audio
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle();

    // Simulate incoming call
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pumpAndSettle();

    // Verify audio paused
    expect(find.text('Audio Paused'), findsOneWidget);

    // Simulate call ended
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    // Verify audio resumed
    expect(find.text('Audio Playing'), findsOneWidget);
  });
}
