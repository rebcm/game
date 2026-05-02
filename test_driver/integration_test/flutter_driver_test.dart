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
        await driver!.close();
      }
    });

    test('Flutter engine inicializado', () async {
      final fltGlassPane = await driver!.waitFor(find.byType('flt-glass-pane'), timeout: Duration(seconds: 10));
      expect(fltGlassPane, isNotNull);
    });
  });
}
