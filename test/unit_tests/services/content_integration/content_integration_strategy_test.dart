import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_integration/hardcoded_content_integration.dart';
import 'package:game/services/content_integration/api_content_integration.dart';
import 'package:game/services/content_integration/local_file_content_integration.dart';

void main() {
  group('ContentIntegrationStrategy', () {
    test('HardcodedContentIntegration', () async {
      final strategy = HardcodedContentIntegration();
      final content = await strategy.getContent();
      expect(content, 'Hardcoded content');
    });

    test('ApiContentIntegration', () async {
      final strategy = ApiContentIntegration('https://example.com/api/content');
      try {
        final content = await strategy.getContent();
        expect(content, isNotEmpty);
      } catch (e) {
        expect(e, isException);
      }
    });

    test('LocalFileContentIntegration', () async {
      final tempFile = await File('temp.txt').writeAsString('Local file content');
      final strategy = LocalFileContentIntegration(tempFile.path);
      final content = await strategy.getContent();
      expect(content, 'Local file content');
      await tempFile.delete();
    });
  });
}
