import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Undo/Redo rebuild benchmark', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simular operações de Undo/Redo e medir o tempo de rebuild
    final stopwatch = Stopwatch()..start();
    await tester.tap(find.text('Undo'));
    await tester.tap(find.text('Redo'));
    await tester.pumpAndSettle();
    stopwatch.stop();

    print('Tempo de rebuild: ${stopwatch.elapsedMilliseconds} ms');
  });
}
