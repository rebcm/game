import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class StressTestHelper {
  static Future<void> stressTestWidget(Widget widget, int durationInSeconds) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.pump(Duration(seconds: durationInSeconds));
  }
}
