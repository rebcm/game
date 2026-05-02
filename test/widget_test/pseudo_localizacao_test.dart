import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/ui/testes/pseudo_localizacao.dart';

void main() {
  testWidgets('Teste de pseudo-localização', (tester) async {
    await tester.pumpWidget(PseudoLocalizacao());

    // Verifica se o widget Hud está presente
    expect(find.byType(Hud), findsOneWidget);

    // Verifica se os textos longos estão sendo exibidos
    for (var i = 0; i < 9; i++) {
      expect(find.text('Texto muito longo para teste $i'), findsOneWidget);
    }
  });
}
