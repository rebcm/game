import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver?.close();
  });

  test('Content Regression Test Driver', () async {
    final timeline = await driver?.traceAction(() async {
      await driver?.tap(find.byType('FloatingActionButton'));
    });
    final summary = TimelineSummary.summarize(timeline!);
    summary.writeSummaryToFile('content_regression_test', pretty: true);
    summary.writeTimelineToFile('content_regression_test', pretty: true);
  });
}
