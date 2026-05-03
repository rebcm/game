import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('No memory leaks after navigating between main screens', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    final leakDetector = LeakDetector();
    await leakDetector.watch(tester, () async {
      // Navigate between main screens
      // Add navigation logic here based on the app's main screens
    });

    expect(leakDetector.hasLeaks, isFalse);
  });
}
