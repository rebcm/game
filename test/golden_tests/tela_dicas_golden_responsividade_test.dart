import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:rebcm/game.dart';

void main() {
  group('Tela de Dicas Golden Responsividade Test', () {
    testGoldens('Tela de Dicas golden responsividade', (tester) async {
      final screenSize = [
        const Size(375, 812), // iPhone 12
        const Size(414, 896), // iPhone 12 Pro Max
        const Size(768, 1024), // iPad
        const Size(1024, 1366), // iPad Pro
      ];

      await tester.pumpWidgetBuilder(
        MaterialApp(
          home: Scaffold(
            body: TelaDicas(),
          ),
        ),
      );

      for (var size in screenSize) {
        await tester.setScreenSize(size);
        await tester.pumpAndSettle();
        await tester.compareGolden(
          tester.binding.window.physicalSize,
          'tela_dicas_golden_${size.width.toInt()}x${size.height.toInt()}',
        );
      }
    });
  });
}
