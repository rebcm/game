import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('FPS Benchmark', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Wait for the game to load
    await Future.delayed(const Duration(seconds: 5));

    // Start measuring FPS
    final stopwatch = Stopwatch()..start();
    int frames = 0;
    while (stopwatch.elapsedMilliseconds < 10000) {
      await tester.pump();
      frames++;
    }
    final fps = frames / (stopwatch.elapsedMilliseconds / 1000);

    // Print the result
    print('FPS: $fps');
    expect(fps, greaterThanOrEqualTo(30));
  });
}
