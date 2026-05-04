import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Input Loss Rate Benchmark', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    int successfulTaps = 0;
    for (int i = 0; i < 100; i++) {
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      successfulTaps++;
    }

    print('Input loss rate: ${(100 - successfulTaps) / 100}%');
  });
}
