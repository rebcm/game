import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_loader.dart';

void main() {
  group('Content Loader Edge Cases', () {
    test('Test API timeout', () async {
      expect(() async => await ContentLoader.loadFromAPI(timeout: Duration(seconds: 1)), throwsException);
    });

    test('Test missing local files', () async {
      expect(() async => await ContentLoader.loadFromLocalFile('non_existent_file.json'), throwsException);
    });

    test('Test invalid JSON parsing', () async {
      expect(() async => await ContentLoader.parseJSON('invalid_json'), throwsException);
    });
  });
}
