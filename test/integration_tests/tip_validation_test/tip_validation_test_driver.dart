import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tip Validation Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('Validate tip visibility', () async {
      final tipFinder = find.byValueKey('construction_tip');
      await driver?.waitFor(tipFinder);
      expect(await driver?.getText(tipFinder), isNotEmpty);
    });

    test('Validate tip content', () async {
      final tipFinder = find.byValueKey('construction_tip');
      final tipText = await driver?.getText(tipFinder);
      expect(tipText, isNotEmpty);
    });
  });
}
