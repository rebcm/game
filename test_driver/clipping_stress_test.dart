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
      final volumeSlider = await driver!.waitFor(find.byValueKey('volumeSlider'));
      await driver!.tap(volumeSlider);
      await Future.delayed(const Duration(seconds: 1));
      await driver!.tap(volumeSlider);
      await Future.delayed(const Duration(seconds: 1));

      final audioGain = await driver!.waitFor(find.byValueKey('audioGain'));
      expect(await audioGain.getText(), 'Audio Gain: OK');
    });
  });
}
