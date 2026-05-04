import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('App startup test', (tester) async {
    final stopwatch = Stopwatch()..start();
    await tester.runAsync(() async {
      await tester.pumpWidget(const MyApp());
    });
    final startupTime = stopwatch.elapsedMilliseconds;
    expect(startupTime, lessThan(5000)); // 5 seconds
  });
}
