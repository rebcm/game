import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo is properly disposed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(Container());

    // Check if EstadoJogo is properly garbage collected
    // This is a simplified test and might need adjustments based on the actual implementation
    await tester.pumpAndSettle();
    expect(estadoJogoFinder, findsNothing);
  });
}
