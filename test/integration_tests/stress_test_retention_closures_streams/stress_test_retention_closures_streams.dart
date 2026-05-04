import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Stress test for retention of closures and streams', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Simulate user interactions that trigger closures and streams
    await tester.tap(find.text('Trigger Closure'));
    await tester.pumpAndSettle();

    // Verify that the expected behavior occurs
    expect(find.text('Expected Outcome'), findsOneWidget);

    // Repeat the test multiple times to stress test
    for (var i = 0; i < 100; i++) {
      await tester.tap(find.text('Trigger Closure'));
      await tester.pumpAndSettle();
      expect(find.text('Expected Outcome'), findsOneWidget);
    }
  });
}
