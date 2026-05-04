import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Driver tests', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver?.close();
    });

    test('FPS Stress Test', () async {
      final timeline = await driver?.traceAction(() async {
        await driver?.tap(find.byType('Slider'));
      });
      final timelineEvents = timeline?.events.where((event) => event['name'] == 'Frame');
      final fps = timelineEvents?.length;
      expect(fps, greaterThanOrEqualTo(30));
    });
  });
}
