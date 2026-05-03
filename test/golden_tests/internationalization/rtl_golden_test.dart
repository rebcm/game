import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/main.dart';

void main() {
  testGoldens('RTL Golden Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        locale: Locale('ar'), // Árabe
        home: MyApp(),
      ),
    );

    await screenMatchesGolden(tester, 'rtl_golden');
  });
}
