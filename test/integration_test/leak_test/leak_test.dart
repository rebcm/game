import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Memory leak test for main screens', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    await expectLeakCountLater(
      () async {
        await tester.tap(find.text('Menu'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();
      },
      0,
    );
  });
}
