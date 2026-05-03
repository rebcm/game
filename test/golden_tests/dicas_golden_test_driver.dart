import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Dicas Golden Tests', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Dicas golden test', () async {
      await driver!.requestData('dicas_golden');
      await driver!.waitUntilNoTransientCallbacks();
    });
  });
}
