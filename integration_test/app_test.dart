import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:test/test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('Test Flutter Driver', () async {
    final FlutterDriver driver = await FlutterDriver.connect();
    await driver.requestData('some_data');
    await driver.close();
  });
}

