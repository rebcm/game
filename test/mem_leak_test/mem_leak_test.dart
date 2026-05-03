import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve vazar memória após dispose', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpAndSettle();

    final estadoJogoWidget = estadoJogoFinder.evaluate().first.widget as EstadoJogo;
    estadoJogoWidget.dispose();

    await tester.pumpAndSettle();

    // Verificar se a instância de EstadoJogo foi removida da memória
    // Isso pode ser feito utilizando o `Flutter DevTools` ou verificando se o widget foi desmontado corretamente
    expect(estadoJogoFinder, findsNothing);
  });
}
