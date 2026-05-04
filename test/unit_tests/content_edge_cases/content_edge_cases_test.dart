import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_service.dart';

void main() {
  group('Content Service Edge Cases', () {
    test('Test API timeout', () async {
      final contentService = ContentService();
      await expectLater(
        contentService.fetchContentWithTimeout(timeout: Duration(milliseconds: 1)),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('Test missing local files', () async {
      final contentService = ContentService();
      await expectLater(
        contentService.loadLocalContent('non_existent_file.json'),
        throwsA(isA<FileNotFoundException>()),
      );
    });

    test('Test invalid JSON parsing', () async {
      final contentService = ContentService();
      await expectLater(
        contentService.parseJson('invalid_json'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
