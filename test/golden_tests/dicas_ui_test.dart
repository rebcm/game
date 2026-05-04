import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/dicas_ui.dart';

void main() {
  group('Dicas UI Golden Tests', () {
    testGoldens('Dicas UI snapshot test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DicasUI(),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden/dicas_ui.png'),
      );
    });

    testGoldens('Dicas UI snapshot test - different size', (tester) async {
      await tester.binding.window.physicalSizeTestValue = Size(800, 600);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: DicasUI(),
        ),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden/dicas_ui_800x600.png'),
      );
    });
  });
}
