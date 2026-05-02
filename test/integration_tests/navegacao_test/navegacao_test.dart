import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navegação', () {
    testWidgets('Navegação básica entre telas', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verifica se a tela inicial é exibida
      expect(find.text('Rebeca\'s World'), findsOneWidget);

      // Simula a navegação para a tela de construção
      await tester.tap(find.text('Construir'));
      await tester.pumpAndSettle();

      // Verifica se a tela de construção é exibida
      expect(find.byType(GridView), findsOneWidget);

      // Simula a navegação de volta para a tela inicial
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verifica se a tela inicial é exibida novamente
      expect(find.text('Rebeca\'s World'), findsOneWidget);
    });
  });
}
