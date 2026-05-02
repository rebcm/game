import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scroll Consistency Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('scrolling test', () async {
      final scrollable = find.byValueKey('scrollable');
      await driver?.scrollUntilVisible(scrollable, find.text('test_item'));
      await driver?.waitFor(find.text('test_item'));
    });
  });
}
