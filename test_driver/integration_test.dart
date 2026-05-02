import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Performance Tests', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Idle animation performance', () async {
      await driver.runUnsynchronized(() async {
        // Wait for the idle animation to start
        await Future.delayed(Duration(seconds: 5));
      });
    });
  });
}
