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

  test('Gameplay integration test', () async {
    final timeline = await driver?.traceAction(() async {
      await driver?.tap(find.byType(ElevatedButton));
      await driver?.waitFor(find.text('Button tapped'));
    });
    final summary = TimelineSummary.summarize(timeline!);
    summary.writeSummaryToFile('gameplay_integration_test', pretty: true);
    summary.writeTimelineToFile('gameplay_integration_test', pretty: true);
  });
}
