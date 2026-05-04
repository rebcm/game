import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Smoke Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('App initializes successfully', () async {
      await driver?.waitUntilFirstFrameRasterized();
      final isAppInitialized = await driver?.waitFor(find.text('Rebeca'));
      expect(isAppInitialized, isNotNull);
    });
  });
}
