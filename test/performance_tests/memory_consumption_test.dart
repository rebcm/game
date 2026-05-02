import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Memory Consumption Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Measure memory consumption', () async {
      final memoryUsage = await driver.waitForFlutterDriverExtension('getMemoryUsage');
      expect(memoryUsage, isNotNull);
      // Define the acceptable memory consumption baseline
      const acceptableMemoryUsage = 200 * 1024 * 1024; // 200 MB
      expect(memoryUsage.usedMemory, lessThan(acceptableMemoryUsage));
    });
  });
}
