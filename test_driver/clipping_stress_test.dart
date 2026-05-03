import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Clipping Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Validate clipping stress test', () async {
      final gainControl = await driver!.tap(find.byValueKey('gain_control'));
      await driver!.waitFor(find.text('Gain Control'));

      // Perform stress test on gain control
      for (int i = 0; i < 100; i++) {
        await driver!.tap(find.byValueKey('increase_gain'));
      }

      // Validate if the sum of proportional volumes does not exceed the hardware decibel limit
      final volume = await driver!.getText(find.byValueKey('current_volume'));
      expect(double.parse(volume), lessThan(100.0)); // Assuming 100.0 is the max decibel limit
    });
  });
}
