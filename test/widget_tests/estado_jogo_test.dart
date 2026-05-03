import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo dispose cancela timers', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EstadoJogo(),
      ),
    );

    final estadoJogoState = tester.state(find.byType(EstadoJogo));

    expect(estadoJogoState.mounted, true);

    await tester.pumpWidget(Container());

    expect(estadoJogoState.mounted, false);
  });
}
