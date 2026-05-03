import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('FPS Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('FPS should be greater than 55', () async {
      final fps = await driver.requestData('fps');
      expect(double.parse(fps!), greaterThan(55));
    });

    test('Jank frames should be less than 10%', () async {
      final jankFrames = await driver.requestData('jank_frames');
      expect(double.parse(jankFrames!), lessThan(10));
    });
  });
}
