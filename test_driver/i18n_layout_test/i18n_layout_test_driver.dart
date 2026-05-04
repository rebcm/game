import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('i18n layout test driver', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('check detailed description layout', () async {
      await driver?.runUnsynchronized(() async {
        await driver?.tap(find.text('Passdriver'));
      });
      // Add more test steps as needed
    });
  });
}
