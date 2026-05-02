import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Fade Transition Stress Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Fade in/out transition', () async {
      final fadeButton = find.byValueKey('fade_button');
      await driver.waitFor(fadeButton);
      for (int i = 0; i < 100; i++) {
        await driver.tap(fadeButton);
        await Future.delayed(Duration(milliseconds: 100));
      }
    });
  });
}
