import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Codec Compatibility Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('play ogg and mp3 files', () async {
      await driver.waitUntilFirstFrameRendered();
      await driver.tap(find.byValueKey('audio_play_button'));
      await Future.delayed(Duration(seconds: 5));
    });
  });
}
