import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Clipping Stress Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Validate audio gain', () async {
      final audioGainFinder = find.byValueKey('audioGain');
      await driver.waitFor(audioGainFinder);
      final audioGain = await driver.getText(audioGainFinder);

      // Assuming the acceptable decibel range is between -60 and 0
      expect(double.parse(audioGain), greaterThanOrEqualTo(-60));
      expect(double.parse(audioGain), lessThanOrEqualTo(0));
    });

    test('Stress test audio gain', () async {
      final volumeSliderFinder = find.byValueKey('volumeSlider');
      await driver.waitFor(volumeSliderFinder);

      for (int i = 0; i < 100; i++) {
        await driver.tap(volumeSliderFinder);
        await Future.delayed(Duration(milliseconds: 50));
      }

      final audioGainFinder = find.byValueKey('audioGain');
      final audioGain = await driver.getText(audioGainFinder);

      expect(double.parse(audioGain), greaterThanOrEqualTo(-60));
      expect(double.parse(audioGain), lessThanOrEqualTo(0));
    });
  });
}
