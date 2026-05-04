import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Content Regression Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Content Regression Test', () async {
      await driver?.runUnsynchronized(() async {
        await driver?.waitFor(find.text('Rebeca'));
        // Add more test steps as needed
      });
    });
  });
}
