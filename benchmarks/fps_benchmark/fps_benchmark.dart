import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('FPS Benchmark', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final fpsList = <double>[];
    const duration = Duration(seconds: 10);

    await tester.runAsync(() async {
      final stopwatch = Stopwatch()..start();
      while (stopwatch.elapsed < duration) {
        await tester.pump();
        fpsList.add(tester.binding.frameRate);
        await Future.delayed(const Duration(milliseconds: 100));
      }
    });

    final averageFps = fpsList.reduce((a, b) => a + b) / fpsList.length;
    print('Average FPS: $averageFps');
    expect(averageFps, greaterThan(30.0));
  });
}
