import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Memory leak test for specific widget', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyHomePage(), // Replace MyHomePage with the widget you want to test
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      tester.runAsync(() async {
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      }),
      leaksNone,
    );
  });
}
