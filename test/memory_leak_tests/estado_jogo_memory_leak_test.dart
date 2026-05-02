import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve vazar memória', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    await tester.binding.watchPerformance(() async {
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    expect(LeakChecker.result, isLeakFree);
  });
}
