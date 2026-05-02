import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Smoke Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Flutter Render Test', () async {
      final fltGlassPane = find.byElementPredicate((element) => element.toString().contains('flt-glass-pane'));
      await driver?.waitFor(fltGlassPane);
    });
  });
}
