import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Idle Animation Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Idle animation stress test', () async {
      await driver!.requestData('start');
      await Future.delayed(Duration(seconds: 10));
      await driver!.requestData('stop');
    });
  });
}
