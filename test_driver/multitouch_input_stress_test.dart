import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Multitouch Input Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Multitouch input stress test', () async {
      final moveGesture = await driver!.startGesture(Offset(100, 100));
      await moveGesture.moveBy(Offset(50, 50));
      await driver!.tap(find.byTooltip('Jump'));
      await driver!.waitFor(find.text('Rebeca'));
      final rotateGesture = await driver!.startGesture(Offset(200, 200));
      await rotateGesture.moveBy(Offset(20, 20));
      await driver!.waitForAbsent(find.text('Loading...'));
    });
  });
}
