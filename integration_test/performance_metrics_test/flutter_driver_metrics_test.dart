import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance Metrics Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('measure frame rate', () async {
      final timeline = await driver.traceAction(() async {
        await driver.tap(find.byValueKey('start_button'));
        await Future.delayed(Duration(seconds: 5));
      });

      final summary = await TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('frame_rate_test', pretty: true);
      summary.writeTimelineToFile('frame_rate_test', pretty: true);
    });

    test('measure memory usage', () async {
      final memoryUsage = await driver.getVmStats();
      print('Memory usage: ${memoryUsage}');
    });
  });
}
