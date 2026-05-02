import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa integridade do artefato', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a validação de um artefato íntegro
    await tester.tap(find.text('Validar Artefato'));
    await tester.pumpAndSettle();
    expect(find.text('Artefato válido'), findsOneWidget);

    // Simula a validação de um artefato corrompido
    await tester.tap(find.text('Corromper Artefato'));
    await tester.tap(find.text('Validar Artefato'));
    await tester.pumpAndSettle();
    expect(find.text('Artefato inválido'), findsOneWidget);
  });
}
