import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  group('Dicas Golden Tests', () {
    testWidgets('Dicas snapshot test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: app.MyHomePage(),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('dicas_golden.png'),
      );
    });

    testWidgets('Dicas snapshot test - different screen size', (tester) async {
      await tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: app.MyHomePage(),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('dicas_golden_large_screen.png'),
      );
    });
  });
}
