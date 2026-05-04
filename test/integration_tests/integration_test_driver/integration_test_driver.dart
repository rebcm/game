import 'package:flutter_driver/flutter_driver.dart' as ftd;
import 'package:test/test.dart';

void main() {
  group('Flutter Integration Tests', () {
    late ftd.FlutterDriver driver;

    setUpAll(() async {
      driver = await ftd.FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Smoke Test', () async {
      await driver.waitUntilNoTransientCallbacks();
    });
  });
}
