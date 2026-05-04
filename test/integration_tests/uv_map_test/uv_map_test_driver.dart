import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver?.close();
    }
  });

  test('UV Map Test', () async {
    final uvMapTestFinder = find.byValueKey('uvMapTest');
    await driver?.waitFor(uvMapTestFinder);
  });
}
