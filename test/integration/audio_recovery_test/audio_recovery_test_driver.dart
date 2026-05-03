import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Audio Recovery Test Driver', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('test audio recovery', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(find.byValueKey('audioBufferStatus'));
      });
    });
  });
}
