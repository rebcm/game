import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Volume Tests Driver', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Volume test', () async {
      final SerializableFinder volumeSlider = find.byTooltip('Volume Slider');
      await driver!.tap(volumeSlider);
      await driver!.enterText('0.5');
      // Add assertions or further interactions as needed
    });
  });
}
