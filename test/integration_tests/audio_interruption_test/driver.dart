import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Audio Interruption Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('should pause and resume audio on interruption', () async {
      // await driver?.tap(find.byTooltip('Play Audio'));
      // await driver?.waitFor(find.text('Audio Playing'));
      // await driver?.tap(find.byTooltip('Interrupt Audio'));
      // await driver?.waitFor(find.text('Audio Paused'));
      // await driver?.tap(find.byTooltip('Resume Audio'));
      // await driver?.waitFor(find.text('Audio Playing'));
    });
  });
}
