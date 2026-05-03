import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/dicas/dicas.dart';

void main() {
  group('Golden Tests - Dicas', () {
    testGoldens('Small Resolution', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dicas(),
          ),
        ),
      );
      await expectLater(
        find.byType(Dicas),
        matchesGoldenFile('dicas_small.png'),
      );
    });

    testGoldens('Medium Resolution', (tester) async {
      await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      await tester.binding.window.devicePixelRatioTestValue = 2.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dicas(),
          ),
        ),
      );
      await expectLater(
        find.byType(Dicas),
        matchesGoldenFile('dicas_medium.png'),
      );
    });

    testGoldens('Large Resolution', (tester) async {
      await tester.binding.window.physicalSizeTestValue = Size(1440, 2560);
      await tester.binding.window.devicePixelRatioTestValue = 3.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dicas(),
          ),
        ),
      );
      await expectLater(
        find.byType(Dicas),
        matchesGoldenFile('dicas_large.png'),
      );
    });
  });
}
