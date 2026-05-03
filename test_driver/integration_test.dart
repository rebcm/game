import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  driver FlutterDriver? driver;
  try {
    driver = await driver FlutterDriver.connect();
  } finally {
    if (driver != null) {
      await driver.close();
    }
  }
  await integrationDriver();
}
