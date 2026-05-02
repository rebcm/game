import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve leak de memória', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EstadoJogo(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final estadoJogo = tester.state<EstadoJogoState>(find.byType(EstadoJogo));

    expect(estadoJogo.mounted, true);

    await tester.pumpWidget(Container());

    await tester.pumpAndSettle();

    expect(estadoJogo.mounted, false);
  });
}
