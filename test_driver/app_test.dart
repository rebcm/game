import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Rebeca App', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Verify flt-glass-pane is rendered', () async {
      final glassPane = await driver?.waitFor(find.byType('flt-glass-pane'), timeout: Duration(seconds: 30));
      expect(glassPane, isNotNull);
    });
  });
}
