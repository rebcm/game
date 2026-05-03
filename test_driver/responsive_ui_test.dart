import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Responsive UI Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Check UI rendering in different resolutions', () async {
      await driver!.waitFor(find.text('Rebeca'));
      // Add more tests for different resolutions and UI elements
    });

    test('Check UI overlay', () async {
      await driver!.tap(find.text('Build'));
      await driver!.waitFor(find.text('Block Type'));
      // Add more tests for UI overlay
    });

    test('Check text expansion in different languages', () async {
      await driver!.tap(find.text('Settings'));
      await driver!.waitFor(find.text('Language'));
      await driver!.tap(find.text('English'));
      await driver!.tap(find.text('Português'));
      // Add more tests for text expansion
    });
  });
}
