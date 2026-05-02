import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Chunk Render Stress Test Driver', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Render chunks in an infinite loop', () async {
      await driver!.waitUntilNoTransientCallbacks();
    }, timeout: Timeout.none);
  });
}
