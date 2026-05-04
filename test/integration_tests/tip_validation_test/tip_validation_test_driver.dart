import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver?.close();
  });

  test('Validate tips UX', () async {
    final tipFinder = find.byValueKey('tip_text');
    await driver?.waitFor(tipFinder);
    expect(await driver?.getText(tipFinder), isNotEmpty);
  });
}
