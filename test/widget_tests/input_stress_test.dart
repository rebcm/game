import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';

void main() {
  testWidgets('Input Stress Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RenderizadorIsometrico(
            mundo: GeradorMundo.gerarMundo(10, 10),
            rebeca: Rebeca(),
          ),
        ),
      ),
    );

    final rebeca = tester.widget<Rebeca>(find.byType(Rebeca));

    await tester.pump();
    await tester.drag(find.byType(RenderizadorIsometrico), Offset(100, 0));
    await tester.pump();
    await tester.drag(find.byType(RenderizadorIsometrico), Offset(-100, 0));
    await tester.pump();

    expect(rebeca.velocidade, isNot(0));
  });
}
