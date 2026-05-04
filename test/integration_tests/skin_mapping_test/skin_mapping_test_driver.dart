import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Skin Mapping Test Driver', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test('should pass skin mapping test', () async {
      final result = await driver?.requestData('skin_mapping_test_result');
      expect(result, 'passed');
    });
  });
}
