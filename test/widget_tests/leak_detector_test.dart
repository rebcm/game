import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('RebecaApp has no memory leaks', (tester) async {
    await tester.pumpWidget(const RebecaApp());
    await tester.pumpAndSettle();
    expect(LeakChecker.result, isLeakFree);
  });
}
