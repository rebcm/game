import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/testes/stress/gerador_movimentacao_rapida.dart';

void main() {
  testWidgets('Teste de stress de chunking', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RenderizadorIsometrico(
            geradorMundo: GeradorMundo(),
          ),
        ),
      ),
    );

    List<Offset> movimentacao = GeradorMovimentacaoRapida.gerarMovimentacaoRapida(1000);
    for (Offset offset in movimentacao) {
      await tester.pump();
      // Simular movimentação da Rebeca
    }

    expect(find.byType(RenderizadorIsometrico), findsOneWidget);
  });
}
