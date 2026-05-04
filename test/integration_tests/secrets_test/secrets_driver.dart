import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;

Future<void> main() async {
  await driverFlutterDriver.runDriver(
    driver: driver FlutterDriver.connect(),
    onDriver: (driver) async {
      await integrationDriver(driver);
    },
  );
}
