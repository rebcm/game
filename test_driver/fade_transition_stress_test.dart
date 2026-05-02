import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Fade Transition Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Fade in/out transition', () async {
      final fadeInButton = find.byValueKey('fade_in_button');
      final fadeOutButton = find.byValueKey('fade_out_button');

      for (var i = 0; i < 100; i++) {
        await driver!.tap(fadeInButton);
        await driver!.tap(fadeOutButton);
      }
    });
  });
}
