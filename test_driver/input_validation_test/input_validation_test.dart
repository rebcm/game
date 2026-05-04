import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Input Validation Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('simultaneous keyboard and touch input', () async {
      final keyboardInput = await driver.waitFor(find.byTooltip('Keyboard Input'));
      final touchInput = await driver.waitFor(find.byTooltip('Touch Input'));

      await driver.tap(touchInput);
      await driver.sendKeyEvent(LogicalKeyboardKey.arrowRight);

      await Future.delayed(Duration(milliseconds: 500));

      expect(await driver.getText(find.byTooltip('Input Status')), 'Both inputs registered');
    });

    test('keyboard input only', () async {
      await driver.sendKeyEvent(LogicalKeyboardKey.arrowLeft);

      await Future.delayed(Duration(milliseconds: 500));

      expect(await driver.getText(find.byTooltip('Input Status')), 'Keyboard input registered');
    });

    test('touch input only', () async {
      final touchInput = await driver.waitFor(find.byTooltip('Touch Input'));
      await driver.tap(touchInput);

      await Future.delayed(Duration(milliseconds: 500));

      expect(await driver.getText(find.byTooltip('Input Status')), 'Touch input registered');
    });
  });
}
