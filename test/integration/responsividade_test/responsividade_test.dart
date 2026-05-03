import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Responsividade Test', () {
    testWidgets('Verificar responsividade em telas pequenas', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpAndSettle();

      expect(find.text('Rebeca'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Verificar truncamento de dicas em telas pequenas', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(280, 480));
      await tester.pumpAndSettle();

      final dicas = find.text('Dicas');
      expect(dicas, findsOneWidget);

      final dicaText = tester.widget<Text>(dicas).data;
      expect(dicaText!.length, lessThanOrEqualTo(20));
    });
  });
}
