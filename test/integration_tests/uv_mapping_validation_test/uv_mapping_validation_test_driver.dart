import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver?.close();
  });

  test('UV Mapping Validation Test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.waitFor(find.text('Rebeca')); // Wait for the app to load
      // Implement driver-based test logic if needed
    });
  });
}
