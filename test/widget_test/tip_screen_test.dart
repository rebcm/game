import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';
import 'package:rebcm/widgets/tip_screen.dart';
import 'package:rebcm/widgets/utils/screen_config.dart';

void main() {
  group('TipScreen Widget Tests', () {
    testWidgets('should not overflow text on different screen sizes', (tester) async {
      for (var breakpoint in ScreenConfig.breakpoints) {
        for (var orientation in ScreenConfig.orientations) {
          await tester.binding.setSurfaceSize(ScreenConfig.getScreenSize(breakpoint, orientation).toSize());
          await tester.pumpWidget(
            MaterialApp(
              home: TipScreen(tipText: 'This is a test tip'),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(OverflowError), findsNothing);
        }
      }
    });
  });
}
