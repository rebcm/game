import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Chunk Size Limit Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('should handle chunk size above the limit', () async {
      await driver.tap(find.byTooltip('Add Chunk'));
      await driver.tap(find.byTooltip('Upload Chunk'));

      final chunkSizeInput = find.byValueKey('chunkSizeInput');
      await driver.enterText(chunkSizeInput, '1000001'); // above the limit

      await driver.tap(find.byTooltip('Upload'));
      final errorMessage = await driver.getText(find.byValueKey('errorMessage'));
      expect(errorMessage, 'Chunk size exceeds the maximum allowed limit');
    });

    test('should handle chunk size at the limit', () async {
      await driver.tap(find.byTooltip('Add Chunk'));
      await driver.tap(find.byTooltip('Upload Chunk'));

      final chunkSizeInput = find.byValueKey('chunkSizeInput');
      await driver.enterText(chunkSizeInput, '1000000'); // at the limit

      await driver.tap(find.byTooltip('Upload'));
      final errorMessage = await driver.getText(find.byValueKey('errorMessage'));
      expect(errorMessage, isEmpty);
    });
  });
}
