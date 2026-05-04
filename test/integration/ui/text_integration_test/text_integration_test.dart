import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  group('UI Text Integration Test', () {
    testWidgets('should display detailed description without layout overflow', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final descriptionText = find.text('Detailed description text that is quite long and should not cause overflow.');
      expect(descriptionText, findsOneWidget);

      final textWidget = tester.widget<Text>(descriptionText);
      expect(textWidget.overflow, TextOverflow.visible);

      await tester.binding.window.physicalSizeTestValue = Size( smallestScreenWidth, smallestScreenHeight);
      await tester.pumpAndSettle();

      expect(find.byType(TextOverflow.ellipsis), findsNothing);
    });

    testWidgets('should adapt to different screen sizes without overflow', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.binding.window.physicalSizeTestValue = Size( smallestScreenWidth, smallestScreenHeight);
      await tester.pumpAndSettle();

      final descriptionText = find.text('Detailed description text that is quite long and should not cause overflow.');
      expect(descriptionText, findsOneWidget);

      final textWidget = tester.widget<Text>(descriptionText);
      expect(textWidget.overflow, isNot(TextOverflow.visible));
    });
  });
}

const double smallestScreenWidth = 320;
const double smallestScreenHeight = 480;
