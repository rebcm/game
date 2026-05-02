import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Input Stress Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Input stress test', () async {
      final animationController = find.byValueKey('animationController');
      for (int i = 0; i < 100; i++) {
        await driver.tap(find.text('Tap me'));
        await Future.delayed(Duration(milliseconds: 50));
      }
      expect(await driver.getText(animationController), 'Animation running');
    });
  });
}
