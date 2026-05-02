import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Persistence Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('simulate app crash after volume change', () async {
      final volumeButton = find.byTooltip('Increase Volume');
      await driver.tap(volumeButton);
      await driver.requestData('crash');
      await driver.waitUntilFirstFrame();
      // Validate data persistence after crash
    });
  });
}
