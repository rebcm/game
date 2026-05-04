import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Acceptance Criteria Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Verify acceptance criteria', () async {
      await driver?.runUnsynchronized(() async {
        await driver?.waitFor(find.text('Rebeca'));
      });
    });
  });
}
