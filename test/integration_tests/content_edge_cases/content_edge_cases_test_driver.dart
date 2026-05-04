import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver?.close();
    }
  });

  test('Content edge cases test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.waitFor(find.text('Game Content'));
    });
  });
}
