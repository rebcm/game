import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Animation Integration Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('Idle to Other States Transition', () async {
      final idleStateFinder = find.byValueKey('idle_state');
      final otherStateFinder = find.byValueKey('other_state');

      await driver?.waitFor(idleStateFinder);
      await driver?.tap(find.byValueKey('transition_button'));
      await driver?.waitFor(otherStateFinder);

      expect(await driver?.getText(otherStateFinder), 'Other State');
    });
  });
}
