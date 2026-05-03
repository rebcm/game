import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Memory Baseline Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Memory baseline test', () async {
      await driver!.runUnsynchronized(() async {
        await driver!.waitFor(find.text('Start'));
        await driver!.tap(find.text('Start'));
      });
    });
  });
}
