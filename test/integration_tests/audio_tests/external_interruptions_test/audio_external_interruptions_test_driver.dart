import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver!.close();
    }
  });

  test('audio external interruptions test', () async {
    final timeline = await driver!.traceAction(() async {
      await driver!.requestData('start-test');
    });

    final summary = TimelineSummary.summarize(timeline);
    summary.writeSummaryToFile('audio_external_interruptions_test', pretty: true);
    summary.writeTimelineToFile('audio_external_interruptions_test', pretty: true);
  });
}
