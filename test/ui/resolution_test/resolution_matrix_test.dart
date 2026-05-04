import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  group('Resolution Matrix Test', () {
    testWidgets('Test UI overflow on different resolutions', (tester) async {
      await tester.pumpWidget(MyApp());

      await tester.binding.window.physicalSizeTestValue = Size(320, 480);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.text('Dicas'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(360, 640);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.text('Dicas'), findsOneWidget);

      await tester.binding.window.physicalSizeTestValue = Size(414, 896);
      await tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpAndSettle();
      expect(find.text('Dicas'), findsOneWidget);
    });
  });
}
