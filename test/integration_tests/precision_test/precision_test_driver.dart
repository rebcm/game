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

  test('precision test', () async {
    await driver?.runUnsynchronized(() async {
      await driver?.tap(find.text('Start'));
      await driver?.waitFor(find.text('Collision detected'));
    });
  });
}
