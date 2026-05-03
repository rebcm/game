import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Dicas UI Test', () {
    testWidgets('Renderização de dicas em diferentes resoluções', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Simula diferentes resoluções de tela
      await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(750, 1334);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);
    });

    testWidgets('Renderização de dicas em diferentes idiomas', (tester) async {
      // Simula o locale para inglês
      await tester.binding.setLocale('en', 'US');
      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Construction Tips'), findsOneWidget);

      // Simula o locale para português
      await tester.binding.setLocale('pt', 'BR');
      await app.main();
      await tester.pumpAndSettle();

      expect(find.text('Dicas de Construção'), findsOneWidget);
    });
  });
}
