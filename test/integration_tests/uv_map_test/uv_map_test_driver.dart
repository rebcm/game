import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('UV Map Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('UV Map Test', () async {
      final textureFinder = find.byType('Image');
      await driver!.waitFor(textureFinder);
      // Add logic to verify UV coordinates or rendered output
    });
  });
}
