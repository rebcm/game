import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_service.dart';
import 'dart:convert';

void main() {
  group('Content Service Edge Cases', () {
    test('Test API timeout', () async {
      final contentService = ContentService();
      await expectLater(
        contentService.fetchContent(timeout: Duration(milliseconds: 1)),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('Test missing local files', () {
      final contentService = ContentService();
      expect(
        contentService.loadLocalContent('non_existent_file.json'),
        throwsA(isA<FileSystemException>()),
      );
    });

    test('Test invalid JSON parsing', () {
      final contentService = ContentService();
      const invalidJson = '{ invalid: json }';
      expect(
        () => jsonDecode(invalidJson),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
