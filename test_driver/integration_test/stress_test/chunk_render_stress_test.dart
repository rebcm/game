import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Chunk Render Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Render chunks in an infinite loop', () async {
      await driver!.runUnsynchronized(() async {
        await driver!.tap(find.byTooltip('Start Stress Test'));
      });
      await Future.delayed(Duration(hours: 1)); // Run for 1 hour
    }, timeout: Timeout.none);
  });
}
