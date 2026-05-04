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

    test('measure performance', () async {
      final timeline = await driver.traceAction(() async {
        await driver.tap(find.byType('ElevatedButton'));
        await Future.delayed(Duration(seconds: 1));
      });

      final summary = TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('performance_test', pretty: true);
      summary.writeTimelineToFile('performance_test', pretty: true);
    });
  });
}
