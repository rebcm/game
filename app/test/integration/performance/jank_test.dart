import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Idle animation performance test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final binding = IntegrationTestWidgetsFlutterBinding.instance;
    binding.enablePerformanceTesting = true;

    await tester.pump(Duration(seconds: 5));

    final frameMetrics = await binding.watchPerformance(() async {
      await tester.pump(Duration(seconds: 10));
    });

    final jankCount = frameMetrics.refreshRate!.round() - frameMetrics.frameCount;
    expect(jankCount, lessThan(5));

    final avgFrameTime = frameMetrics.cumulativeFrameTime ~/ frameMetrics.frameCount;
    expect(avgFrameTime, lessThan(16)); // 60 FPS

    print('Jank count: $jankCount');
    print('Average frame time: $avgFrameTime ms');
  });
}
