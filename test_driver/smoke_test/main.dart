import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Smoke Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Flutter engine inicializado', () async {
      final glassPaneFinder = find.bySemanticsLabel('flt-glass-pane');
      await driver?.waitFor(glassPaneFinder, timeout: Duration(seconds: 10));
    });
  });
}
