import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/ui/dicas.dart';

void main() {
  group('Dicas UI Golden Tests', () {
    testGoldens('Dicas UI snapshot test', (tester) async {
      final builder = DeviceBuilder()
        ..overrideForAllScenarios(
          (scenario) => scenario.copyWith(
            themeData: ThemeData.light(),
          ),
        )
        ..addScenario(
          name: 'default theme',
          widget: Dicas(),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'dicas_ui_golden');
    });
  });
}
