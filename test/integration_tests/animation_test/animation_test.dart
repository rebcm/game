import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Idle to other states animation test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find the Rive animation widget
    final riveAnimationFinder = find.byType(RiveAnimation);
    expect(riveAnimationFinder, findsOneWidget);

    // Check initial state is Idle
    final riveAnimation = tester.widget<RiveAnimation>(riveAnimationFinder);
    expect(riveAnimation.state, 'Idle');

    // Simulate state change to other states and verify animation
    // This part should be implemented based on the actual state change logic
    // For example:
    await tester.tap(find.text('Change State')); // Replace with actual widget or action
    await tester.pumpAndSettle();
    expect(riveAnimation.state, isNot('Idle'));
  });
}
