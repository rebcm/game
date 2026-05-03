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

    final estadoJogo = tester.state<EstadoJogoState>(find.byType(EstadoJogo));
    expect(estadoJogo.mounted, isTrue);

    await tester.pumpWidget(Container());

    expect(estadoJogo.mounted, isFalse);
  });
}
