import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Multitouch Edge Cases Test Driver', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Multitouch Edge Cases Test', () async {
      final timeline = await driver!.traceAction(() async {
        await driver!.requestData('multitouch_edge_cases_test');
      });

      final summary = TimelineSummary.summarize(timeline);
      await summary.writeSummaryToFile('multitouch_edge_cases_test', pretty: true);
      await summary.writeTimelineToFile('multitouch_edge_cases_test', pretty: true);
    });
  });
}
