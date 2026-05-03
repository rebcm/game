import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:game/utils/resolution_constants.dart';

void main() {
  group('Dicas UI Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Validate dicas screen UI', () async {
      for (var device in ResolutionConstants.targetDevices) {
        await driver!.requestData('setDevice: $device');
        await driver!.waitFor(find.text('Dicas')); // Assuming 'Dicas' is a text on the dicas screen
        await driver!.waitUntilNoTransientCallbacks();
        expect(await driver!.getText(find.text('Dicas')), 'Dicas');
      }
    });
  });
}
