import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:test/test.dart';

void main() {
  test('performance test', () async {
    final FlutterDriver driverInstance = await driver FlutterDriver.connect();
    final performance = await driverInstance.checkPerformance();
    await driverInstance.close();
    // Process performance data
  });
}
