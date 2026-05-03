import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Audio Concurrency Stress Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('should play multiple sounds concurrently without crashing', () async {
      await driver!.waitFor(find.byTooltip('Play Sound'));
      for (int i = 0; i < 100; i++) {
        await driver!.tap(find.byTooltip('Play Sound'));
        await Future.delayed(Duration(milliseconds: 50));
      }
      await Future.delayed(Duration(seconds: 2)); // wait for sounds to finish playing
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
