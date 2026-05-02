import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Idle animation jank test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final stopwatch = Stopwatch()..start();
    int frames = 0;

    while (stopwatch.elapsedMilliseconds < 10000) {
      await tester.pump();
      frames++;
    }

    final fps = frames / (stopwatch.elapsedMilliseconds / 1000);
    expect(fps, greaterThanOrEqualTo(30));
  });
}
