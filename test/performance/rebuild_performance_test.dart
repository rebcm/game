import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/utils/performance_testing/performance_tester.dart';

void main() {
  testWidgets('Comparar FPS e rebuilds entre versão global e granular',
      (WidgetTester tester) async {
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();

    final performanceTester = PerformanceTester(tester);
    await performanceTester.runPerformanceTest();

    expect(performanceTester.fps, greaterThan(60));
    expect(performanceTester.rebuildCount, lessThan(10));
  });
}
