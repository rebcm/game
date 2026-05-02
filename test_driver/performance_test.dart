import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance Tests', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Measure frame timing', () async {
      final timeline = await driver.traceAction(() async {
        await Future.delayed(Duration(seconds: 5));
      });
      final timelineSummary = TimelineSummary.summarize(timeline);
      timelineSummary.writeSummaryToFile('performance_test', pretty: true);
      timelineSummary.writeTimelineToFile('performance_test', pretty: true);
    });
  });
}
