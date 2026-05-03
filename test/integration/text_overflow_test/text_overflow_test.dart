import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa overflow de texto em Alemão e Francês', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula mudança de idioma para Alemão
    await tester.tap(find.byTooltip('Mudar Idioma'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Deutsch'));
    await tester.pumpAndSettle();

    // Verifica se há overflow de texto
    expect(find.byType(TextOverflowError), findsNothing);

    // Simula mudança de idioma para Francês
    await tester.tap(find.byTooltip('Mudar Idioma'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();

    // Verifica se há overflow de texto
    expect(find.byType(TextOverflowError), findsNothing);
  });
}
