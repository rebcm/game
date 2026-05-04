// Update the import to include golden_toolkit
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/main.dart' as app;

void main() {
  group('Dicas UI Golden Tests', () {
    testGoldens('Dicas UI snapshot test', (tester) async {
      await tester.pumpWidgetBuilder(app.MyApp());

      await screenMatchesGolden(tester, 'dicas_ui');
    });

    testGoldens('Dicas UI snapshot test - different screen size', (tester) async {
      await tester.pumpWidgetBuilder(app.MyApp());
      await tester.binding.window.physicalSizeTestValue = Size(1920, 1080);

      await screenMatchesGolden(tester, 'dicas_ui_large_screen');
    });
  });
}
