import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Memory Profiling Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Check memory usage', () async {
      await driver.requestData('start');
      await Future.delayed(Duration(seconds: 10));
      await driver.requestData('stop');
    });
  });
}
