import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Build performance test', (tester) async {
    final stopwatch = Stopwatch()..start();
    await tester.pumpWidget(const MyApp());
    final buildTime = stopwatch.elapsedMilliseconds;
    expect(buildTime, lessThan(3000)); // 3 seconds
  });
}
