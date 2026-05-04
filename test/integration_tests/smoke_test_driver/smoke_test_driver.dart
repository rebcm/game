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

  test('smoke test driver', () async {
    await driver?.waitUntilNoTransientCallbacks();
  });
}
