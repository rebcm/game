import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('EstadoJogo não vaza memória', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    expect(MemoryLeakChecker().isDisposed(estadoJogoFinder.evaluate().first), isTrue);
  });
}
