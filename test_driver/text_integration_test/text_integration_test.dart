import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Text Integration Test', () {
    testWidgets('Verify text fits in UI components', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final textFinder = find.text('Descrição detalhada do bloco');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      final textSize = textWidget.style?.fontSize ?? 0;

      final textContainer = tester.widget<Container>(find.ancestor(of: textFinder, matching: find.byType(Container)));
      final containerWidth = textContainer.constraints?.maxWidth ?? 0;

      expect(containerWidth, greaterThan(0));
      expect(textSize, greaterThan(0));

      final textSpan = TextSpan(text: 'Descrição detalhada do bloco', style: textWidget.style);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: containerWidth);

      expect(textPainter.didExceedMaxLines, isFalse);
    });

    testWidgets('Verify text does not overflow in different screen sizes', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final textFinder = find.text('Descrição detalhada do bloco');
      expect(textFinder, findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      await tester.pumpAndSettle();

      final textWidget = tester.widget<Text>(textFinder);
      final textContainer = tester.widget<Container>(find.ancestor(of: textFinder, matching: find.byType(Container)));
      final containerWidth = textContainer.constraints?.maxWidth ?? 0;

      final textSpan = TextSpan(text: 'Descrição detalhada do bloco', style: textWidget.style);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: containerWidth);

      expect(textPainter.didExceedMaxLines, isFalse);
    });
  });
}
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // ... existing code ...

  test('run golden tests', () async {
    final FlutterDriver driver = await FlutterDriver.connect();
    await driver.requestData('run golden tests');
    await driver.close();
  });
}
