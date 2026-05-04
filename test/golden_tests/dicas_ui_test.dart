import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/dicas_ui.dart';

void main() {
  group('Dicas UI Golden Tests', () {
    testGoldens('Dicas UI renders correctly on different screen sizes', (tester) async {
      final builder = DeviceBuilder()
        ..overrideForAll(
          (device) => device.copyWith(
            platform: TargetPlatform.android,
          ),
        )
        ..addScenario(
          device: Device.phone,
          name: 'Dicas UI on phone',
          widget: DicasUI(),
        )
        ..addScenario(
          device: Device.tablet,
          name: 'Dicas UI on tablet',
          widget: DicasUI(),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'dicas_ui_golden');
    });
  });
}
