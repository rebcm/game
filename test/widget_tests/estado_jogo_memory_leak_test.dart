import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve ter vazamento de memória', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    final estadoJogoKey = Key('estado_jogo_key');
    final estadoJogoFinder = find.byKey(estadoJogoKey);

    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: Container(),
      ),
    );

    await tester.pumpAndSettle();

    expect(estadoJogoFinder, findsNothing);

    await expectLater(
      MemoryLeakChecker.checkForLeaks(),
      completion(isEmpty),
    );
  });
}
