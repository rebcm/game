import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart' as driver_extension;

Future<void> main() async {
  await driver_extension.integrationDriver(
    driver: driver FlutterDriver(
      dartVmServiceUrl: 'http://localhost:8888',
    ),
  );
}
