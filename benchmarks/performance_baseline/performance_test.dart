import 'package:flutter/material.dart';
import 'package:game/main.dart' as game_main;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Memory Consumption Benchmark', (tester) async {
    await tester.pumpWidget(game_main.MyApp());
    await tester.pumpAndSettle();

    final memoryUsage = MemoryInfo.currentHeapSize;
    print('Memory Usage: $memoryUsage');

    // Add expectation based on acceptable memory usage
  });
}
