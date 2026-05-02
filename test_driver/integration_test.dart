import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (FlutterDriver driver, String name, List<int> png) async {
      // Process screenshot if needed
      return true;
    },
  );
}
