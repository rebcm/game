import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Frame timing test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final List<double> frameTimes = [];

    SchedulerBinding.instance.addTimingsCallback((timings) {
      for (final FrameTiming timing in timings) {
        frameTimes.add(timing.totalDuration.inMicroseconds.toDouble());
      }
    });

    await tester.pump(const Duration(seconds: 5));

    SchedulerBinding.instance.cancelTimingsCallback((timings) {
      for (final FrameTiming timing in timings) {
        frameTimes.add(timing.totalDuration.inMicroseconds.toDouble());
      }
    });

    expect(frameTimes, isNotEmpty);
    print('Frame times: $frameTimes');
  });
}
