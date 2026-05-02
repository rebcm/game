import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Idle animation jank test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final initialFrameTime = tester.binding.renderView.lastFrameTimeStamp;
    await tester.pump(const Duration(seconds: 1));
    final finalFrameTime = tester.binding.renderView.lastFrameTimeStamp;

    final frameCount = tester.binding.frameCount;
    final frameTime = finalFrameTime - initialFrameTime;

    expect(frameCount, greaterThan(0));
    expect(frameTime.inMilliseconds, lessThan(frameCount * 16)); // 60 FPS

    final cpuUsage = await tester.binding.globalTestState.cpuUsage;
    expect(cpuUsage, lessThan(0.5)); // 50% CPU usage
  });
}
