import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Chunk Transition Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Chunk transition stress test', () async {
      final fpsSer = await driver?.tap(find.byValueKey('fps_serial'));
      expect(fpsSer, isNotNull);
      final fpsVal = await driver?.getText(find.byValueKey('fps_value'));
      expect(int.parse(fpsVal!), greaterThanOrEqualTo(30));
    });
  });
}
