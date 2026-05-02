import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter DOM Validation Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver?.close();
    });

    test('Check if Flutter rendered', () async {
      await driver?.waitFor(find.byType('flt-glass-pane'));
    });
  });
}
