import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Rebeca rebuild benchmark', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simular operações de Undo/Redo
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Undo'));
      await tester.pump();
      await tester.tap(find.text('Redo'));
      await tester.pump();
    }

    // Medir o tempo de rebuild
    final stopwatch = Stopwatch()..start();
    await tester.pump();
    stopwatch.stop();
    print('Tempo de rebuild: ${stopwatch.elapsedMilliseconds} ms');
  });
}
