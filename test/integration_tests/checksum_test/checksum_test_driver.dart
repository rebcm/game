import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Checksum Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver?.close();
      }
    });

    test('Checksum validation', () async {
      await driver?.requestData('checksum');
    });
  });
}
