import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('CPU Stress Test', () async {
      final timeline = await driver.traceAction(() async {
        await driver.tap(find.byTooltip('Build Button'));
        await Future.delayed(Duration(seconds: 10));
      });

      final summary = TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('benchmark_results', pretty: true);
      summary.writeTimelineToFile('benchmark_timeline', pretty: true);
    });
  });
}
