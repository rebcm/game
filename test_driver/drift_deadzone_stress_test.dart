import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Drift Deadzone Stress Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Simulate minimum and unstable inputs', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(find.byTooltip('Joystick'));
        await Future.delayed(Duration(milliseconds: 100));
        await driver.tap(find.byTooltip('Joystick'));
      });
    });

    test('Validate deadzone efficacy', () async {
      final deadzone = await driver.getText(find.byType('DeadzoneIndicator'));
      expect(deadzone, 'Within Deadzone');
    });
  });
}
