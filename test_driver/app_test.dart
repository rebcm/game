import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Render Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('check flutter view', () async {
      final flutterView = await driver?.waitFor(find.byType('FlutterView'));
      expect(flutterView, isNotNull);
    });
  });
}
