import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  test('global shortcuts test', () async {
    final FlutterDriver driver = await FlutterDriver.connect();
    await driver.requestData('global_shortcuts_test');
    await driver.close();
  });
}
