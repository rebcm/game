import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Teste de overflow de texto em idiomas longos', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simula mudança de idioma para Alemão e Francês
    await tester.binding.setLocale('de');
    await tester.pumpAndSettle();

    // Verifica se há overflow de texto
    expect(find.byType(OverflowError), findsNothing);

    await tester.binding.setLocale('fr');
    await tester.pumpAndSettle();

    expect(find.byType(OverflowError), findsNothing);
  });
}
