import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('No memory leaks after navigating between main screens', (tester) async {
    await tester.pumpWidget(const app.MyApp());

    // Navigate through main screens
    await tester.tap(find.text('Settings')); // Assuming there's a button/text with 'Settings'
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back')); // Assuming there's a button/text with 'Back'
    await tester.pumpAndSettle();

    // Check for leaks
    await expectLater(
      tester.runAsync(() async {
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      }),
      leaksNone,
    );
  });
}
