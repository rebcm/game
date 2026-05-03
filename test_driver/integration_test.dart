import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Integration Tests', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver?.close();
    });

    test('verify app starts', () async {
      await driver?.waitFor(find.text('Rebeca\'s Creative Mode'));
    });
  });
}
