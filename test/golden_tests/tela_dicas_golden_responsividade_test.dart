import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game.dart';

void main() {
  testGoldens('Tela de Dicas golden responsiva', (tester) async {
    final builder = DeviceBuilder()
      ..overrideFor(
        Device.appleIPhoneSE,
        (b) => b..textScaleFactor = 1,
      );
    await tester.pumpDeviceBuilder(builder);
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Dicas'));
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'tela_dicas_golden_responsiva');
  });
}
