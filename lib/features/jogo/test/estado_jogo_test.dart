import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/jogo/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo timers are cancelled when widget is disposed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    await tester.pumpAndSettle();

    final estadoJogo = tester.state<EstadoJogoState>(find.byType(EstadoJogo));

    expect(estadoJogo.mounted, true);

    await tester.pumpWidget(Container());

    expect(estadoJogo.mounted, false);
  });
}
