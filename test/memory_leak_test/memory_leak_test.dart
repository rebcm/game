import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo.dart is properly disposed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(Container());

    // Verificar se o widget foi removido da árvore de widgets
    expect(estadoJogoFinder, findsNothing);
  });
}
