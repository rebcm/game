import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Rendering Validation', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Validate Flutter rendering', () async {
      final fltGlassPane = await driver!.waitFor(find.byType('flt-glass-pane'), timeout: Duration(seconds: 10));
      expect(fltGlassPane, isNotNull);
    });
  });
}
