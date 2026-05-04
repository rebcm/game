import 'package:flutter_test/flutter_test.dart';
import 'package:game/content/content_loader.dart';

void main() {
  group('Content Loader Edge Cases', () {
    test('Test API timeout', () async {
      expect(() async => await ContentLoader.loadContent(timeout: Duration(milliseconds: 1)), throwsException);
    });

    test('Test missing local files', () async {
      expect(() async => await ContentLoader.loadContent(filePath: 'non_existent_file.json'), throwsException);
    });

    test('Test invalid JSON parsing', () async {
      expect(() async => await ContentLoader.loadContent(jsonString: '{ invalid_json }'), throwsException);
    });
  });
}
