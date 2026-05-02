import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Idle animation stress test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate idle animation for 10 seconds
    await tester.pump(Duration(seconds: 10));

    // Verify frame rate
    expect(tester.binding.frameRate, isNot(lessThan(60)));
  });
}
