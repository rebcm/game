import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('GC Trigger Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('trigger gc and wait', () async {
      await driver.runUnsynchronized(() async {
        await Future.delayed(const Duration(milliseconds: 100));
        await driver.requestHeapSnapshot();
      });
      await Future.delayed(const Duration(milliseconds: 500));
    });
  });
}
