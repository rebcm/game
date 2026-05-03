import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  group('Dicas UI Test', () {
    testWidgets('Renderização de texto em diferentes resoluções', (tester) async {
      await tester.pumpWidget(app.MyApp());

      // Simula diferentes resoluções de tela
      await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.textContaining('Dica'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(750, 1334);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.textContaining('Dica'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(1440, 2560);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.textContaining('Dica'), findsOneWidget);
    });

    testWidgets('Renderização de texto em diferentes idiomas', (tester) async {
      await tester.pumpWidget(app.MyApp());

      // Simula diferentes idiomas
      await tester.binding.window.localeTestValue = Locale('en', 'US');
      await tester.pumpAndSettle();
      expect(find.textContaining('Tip'), findsOneWidget);

      await tester.binding.window.localeTestValue = Locale('pt', 'BR');
      await tester.pumpAndSettle();
      expect(find.textContaining('Dica'), findsOneWidget);
    });
  });
}
