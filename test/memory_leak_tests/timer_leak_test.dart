import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/jogo.dart';

void main() {
  testWidgets('Timers são cancelados após destruição do EstadoJogo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EstadoJogo(),
        ),
      ),
    );

    final estadoJogo = tester.state(find.byType(EstadoJogo));

    // Verificar se os timers estão ativos antes da destruição
    expect(estadoJogo.timersAtivos, true);

    await tester.pumpWidget(Container());

    // Verificar se os timers foram cancelados após a destruição
    expect(estadoJogo.timersAtivos, false);
  });
}
