import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/jogo.dart';

void main() {
  testWidgets('EstadoJogo não permanece ativo após destruição', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EstadoJogo(),
        ),
      ),
    );

    final estadoJogo = tester.state(find.byType(EstadoJogo));

    await tester.pumpWidget(Container());

    expect(estadoJogo.mounted, false);
  });
}
