import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Responsividade em Telas Pequenas', () {
    testWidgets('Verificar wrap e truncamento de dicas em telas pequenas', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpAndSettle();

      final dicasFinder = find.text('Dicas');
      expect(dicasFinder, findsOneWidget);

      final dicaTextFinder = find.text('Texto da Dica');
      expect(dicaTextFinder, findsOneWidget);

      final dicaWidget = tester.widget<Text>(dicaTextFinder);
      expect(dicaWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
