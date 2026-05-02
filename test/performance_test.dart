import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance Testing', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Frame Time', () async {
      await driver.waitFor(find.byType('PerformanceProfilingPage'));
      await driver.tap(find.text('Toggle Performance Overlay'));
      await driver.waitUntilNoTransientCallbacks();
      final frameTime = await driver.getPerformance();
      expect(frameTime, lessThan(1000));
    });

    test('CPU/GPU Utilization', () async {
      await driver.waitFor(find.byType('PerformanceProfilingPage'));
      await driver.tap(find.text('Toggle Performance Overlay'));
      await driver.waitUntilNoTransientCallbacks();
      final cpuUtilization = await driver.getCPUPerformance();
      final gpuUtilization = await driver.getGPUPerformance();
      expect(cpuUtilization, lessThan(100));
      expect(gpuUtilization, lessThan(100));
    });
  });
}
