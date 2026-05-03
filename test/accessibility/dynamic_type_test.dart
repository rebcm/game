import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game.dart';

void main() {
  testGoldens('Dynamic Type Test - Extra Large', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: Scaffold(
          body: Game(),
        ),
      ),
      surfaceSize: Size(800, 600),
      textScale: 2.0,
    );

    await screenMatchesGolden(tester, 'dynamic_type_extra_large');
  });
}
