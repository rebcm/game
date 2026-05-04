import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('GC Forcing Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('GC Forcing Test', () async {
      await driver?.requestData('gc');
      await driver?.waitUntilNoTransientCallbacks();
    });
  });
}
