import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/main.dart' as app;

void main() {
  testGoldens('UV Map Test', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        home: app.MyApp(),
      ),
      surfaceSize: const Size(800, 600),
    );
    await screenMatchesGolden(tester, 'uv_map_golden');
  });
}
