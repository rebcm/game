import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() async {
  testGoldens('Passdriver description i18n test', (tester) async {
    await tester.pumpWidgetTree(
      MaterialApp(
        home: MyApp(),
        locale: Locale('de', 'DE'), // German locale for expanded text
      ),
    );

    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'passdriver_description_german');
  });

  testGoldens('Passdriver description i18n test french', (tester) async {
    await tester.pumpWidgetTree(
      MaterialApp(
        home: MyApp(),
        locale: Locale('fr', 'FR'), // French locale for expanded text
      ),
    );

    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'passdriver_description_french');
  });
}
