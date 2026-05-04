import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Frame timing test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final List<double> frameTimes = [];
    SchedulerBinding.instance.addPersistentFrameCallback((_) {
      frameTimes.add(SchedulerBinding.instance.currentFrameTimeStamp.inMilliseconds.toDouble());
    });

    await tester.pump(const Duration(seconds: 5));

    expect(frameTimes, isNotEmpty);
    expect(frameTimes.length, greaterThan(0));

    final averageFrameTime = frameTimes.reduce((a, b) => a + b) / frameTimes.length;
    print('Average frame time: $averageFrameTime ms');

    expect(averageFrameTime, lessThan(33.33)); // 30 FPS
  });
}
