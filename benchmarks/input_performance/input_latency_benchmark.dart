import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Input Latency Benchmark', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final stopwatch = Stopwatch()..start();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    stopwatch.stop();

    print('Input latency: ${stopwatch.elapsedMilliseconds} ms');
  });
}
