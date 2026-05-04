import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Texture Bleeding Test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver!.close();
      }
    });

    test('Texture bleeding test', () async {
      final voxelBlock = find.byValueKey('voxel_block');
      await driver!.waitFor(voxelBlock);
    });
  });
}
