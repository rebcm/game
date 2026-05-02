import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  driverFlutterDriver = await driverFlutterDriver.connect();
  await integrationDriver();
}
