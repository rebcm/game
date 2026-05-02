import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Render Validation', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Verify Flutter rendered element', () async {
      final fltGlassPane = await driver.waitFor(find.byType('flt-glass-pane'), timeout: Duration(seconds: 10));
      expect(fltGlassPane, isNotNull);
    });
  });
}
