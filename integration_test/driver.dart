import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver!.close();
    }
  });

  test('Audio integration test', () async {
    await driver!.waitFor(find.byIcon(Icons.play_arrow));
    await driver!.tap(find.byIcon(Icons.play_arrow));
    await driver!.waitFor(find.text('Audio playing'));

    await driver!.tap(find.byIcon(Icons.pause));
    await driver!.waitFor(find.text('Audio paused'));

    await driver!.tap(find.byIcon(Icons.stop));
    await driver!.waitFor(find.text('Audio stopped'));
  });
}
