import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Dicas UI Test', () {
    testWidgets('Renderização de dicas em diferentes resoluções', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(750, 1334);
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(480, 854);
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);
    });

    testWidgets('Renderização de dicas em diferentes idiomas', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simula mudança de idioma para inglês
      // Implemente a lógica para mudar o idioma aqui
      await tester.pumpAndSettle();

      expect(find.text('Building Tips'), findsOneWidget);

      // Simula mudança de idioma para português
      // Implemente a lógica para mudar o idioma aqui
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);
    });
  });
}
