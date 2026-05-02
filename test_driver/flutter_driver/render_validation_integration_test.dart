import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes) async {
      return true;
    },
  );
}
