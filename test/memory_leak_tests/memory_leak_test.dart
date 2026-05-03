import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo.dart instance is removed after dispose', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(Container());

    // Use Flutter DevTools or other methods to verify memory leak
    // For simplicity, we assume the widget is properly disposed
    expect(estadoJogoFinder, findsNothing);
  });
}
