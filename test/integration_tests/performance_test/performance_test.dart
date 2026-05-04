import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('measure frame performance during animation transitions', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final finder = find.byType(AnimatedBuilder);
    expect(finder, findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    final performance = await tester.binding.watchPerformance(() async {
      await tester.pump(Duration(seconds: 1));
    });

    expect(performance.frameCount, greaterThan(0));
    expect(performance.averageFrameRate, greaterThan(30));
  });
}
