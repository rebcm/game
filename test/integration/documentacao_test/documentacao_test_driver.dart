import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (driver.RequestData request, String? pngBase64) async {
      return true;
    },
  );
}
