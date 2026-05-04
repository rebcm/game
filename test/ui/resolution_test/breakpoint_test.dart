import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('Breakpoint Test', () {
    testWidgets('Test UI breakpoint on different devices', (tester) async {
      await tester.pumpWidget(MyApp());

      await tester.binding.window.physicalSizeTestValue = Size(320, 480);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.text('Dicas'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(768, 1024);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.text('Dicas'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(1024, 1366);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.text('Dicas'), findsOneWidget);
    });
  });
}
