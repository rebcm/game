import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('Verifica se EstadoJogo é removido da memória após dispose', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoFinder = find.byType(EstadoJogo);
    expect(estadoJogoFinder, findsOneWidget);

    await tester.pumpWidget(Container());

    // Aguarda um frame para garantir que o dispose seja chamado
    await tester.pump();

    // Verifica se a instância de EstadoJogo ainda existe
    final estadoJogoInstance = tester.state(estadoJogoFinder);
    expect(estadoJogoInstance.mounted, false);
  });
}
