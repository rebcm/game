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

      // Simula diferentes resoluções de tela
      await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();

      expect(find.text('Texto da dica'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(750, 1334);
      await tester.binding.window.devicePixelRatioTestValue = 2.0;
      await tester.pumpAndSettle();

      expect(find.text('Texto da dica'), findsOneWidget);
    });

    testWidgets('Renderização de dicas em diferentes idiomas', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simula mudança de idioma
      // Implemente a lógica para mudar o idioma da aplicação
      await tester.pumpAndSettle();

      expect(find.text('Texto da dica em outro idioma'), findsOneWidget);
    });
  });
}
