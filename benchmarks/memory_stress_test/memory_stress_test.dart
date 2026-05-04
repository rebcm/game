import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Memory Stress Test: Fade In/Out 100 times', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    for (int i = 0; i < 100; i++) {
      await tester.tap(find.text('Fade'));
      await tester.pumpAndSettle();
    }
  });
}
