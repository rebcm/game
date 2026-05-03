import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('IO Latency Metrics Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('measure cold start latency', () async {
      final timeline = await driver?.traceAction(() async {
        await driver?.requestData('start');
      });
      final summary = TimelineSummary.summarize(timeline!);
      summary.writeSummaryToFile('cold_start_latency', pretty: true);
    });

    test('measure cached start latency', () async {
      final timeline = await driver?.traceAction(() async {
        await driver?.requestData('start');
      });
      final summary = TimelineSummary.summarize(timeline!);
      summary.writeSummaryToFile('cached_start_latency', pretty: true);
    });
  });
}
