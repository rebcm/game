import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Volume Control Compatibility Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('Test volume control with physical buttons', () async {
      final volumeControlButton = await driver?.tap(find.byValueKey('volumeControlButton'));
      await driver?.waitForAbsent(find.text('Volume Control Conflict'));
      expect(await driver?.getText(find.text('Volume Control Compatible')), 'Volume Control Compatible');
    });
  });
}
