import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('animation test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('animation performance test', () async {
      final timeline = await driver?.traceAction(() async {
        await driver?.tap(find.byValueKey('animation_trigger'));
      });

      final summary = await driver?.traceAction(() async {
        await driver?.tap(find.byValueKey('animation_trigger'));
      });

      expect(summary?.events.where((event) => event.name == 'Flutter.Frame').length, greaterThan(0));
    });
  });
}
