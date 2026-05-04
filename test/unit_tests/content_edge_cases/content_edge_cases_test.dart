import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_loader.dart';

void main() {
  group('Content Loader Edge Cases', () {
    test('Test timeout during API call', () async {
      // Simulate API timeout
      expect(await ContentLoader.loadContent(timeout: Duration(seconds: 1)), throwsA(isA<TimeoutException>()));
    });

    test('Test missing local files', () async {
      // Simulate missing local files
      expect(await ContentLoader.loadLocalContent('non_existent_file.json'), throwsA(isA<FileSystemException>()));
    });

    test('Test invalid JSON parsing', () async {
      // Simulate invalid JSON
      expect(() => ContentLoader.parseJson('invalid_json'), throwsA(isA<FormatException>()));
    });
  });
}
