import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() async {
  testGoldens('Tela de dicas golden RTL test', (tester) async {
    final builder = DeviceBuilder()
      ..overrideLocale(Locale('ar')) // Arabic locale for RTL test
      ..addScenario(
        name: 'Tela de dicas',
        widget: DicasTela(),
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'tela_dicas_rtl_golden');
  });
}
