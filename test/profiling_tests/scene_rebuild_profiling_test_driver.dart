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

  test('Profile scene rebuilds', () async {
    await driver?.traceAction(() async {
      await driver?.tap(find.byTooltip('Undo'));
      await driver?.tap(find.byTooltip('Redo'));
    });
  });
}
