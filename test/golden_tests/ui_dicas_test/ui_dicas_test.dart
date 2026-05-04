import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/ui/dicas.dart';

void main() {
  testGoldens('UI de Dicas Golden Test', (tester) async {
    final builder = DeviceBuilder()
      ..overrideForAll(
        (widget) => MaterialApp(
          home: Scaffold(
            body: Dicas(),
          ),
        ),
      )
      ..addScenario(
        name: 'Dicas UI',
        widget: Dicas(),
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dicas_ui_golden');
  });
}
