import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Memory Baseline Test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Wait for the app to be idle
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Measure memory usage
    final memoryUsage = MemoryInfo.currentHeapSize;
    print('Memory usage: $memoryUsage');

    // Perform some actions to measure peak memory usage
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Build'));
      await tester.pumpAndSettle();
    }

    // Measure peak memory usage
    final peakMemoryUsage = MemoryInfo.currentHeapSize;
    print('Peak memory usage: $peakMemoryUsage');

    expect(memoryUsage, isNotNull);
    expect(peakMemoryUsage, isNotNull);
  });
}
