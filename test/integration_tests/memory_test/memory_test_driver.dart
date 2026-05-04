import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Memory Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Garbage Collection Trigger Test', () async {
      await driver.requestData('init');
      await Future.delayed(Duration(seconds: 5));
      await driver.requestData('gc');
      await Future.delayed(Duration(seconds: 2));
      await driver.requestData('check_memory');
    });
  });
}
