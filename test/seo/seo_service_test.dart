import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/seo/seo_service.dart';

void main() {
  group('SeoService', () {
    late SeoService seoService;

    setUp(() {
      seoService = SeoService();
    });

    test('initial keywords list is empty', () {
      expect(seoService.keywords, isEmpty);
    });

    test('updateKeywords updates the keywords list', () {
      final newKeywords = ['flutter', 'game', 'voxel'];
      seoService.updateKeywords(newKeywords);
      expect(seoService.keywords, newKeywords);
    });

    test('addKeyword adds a new keyword to the list', () {
      final keyword = 'creative mode';
      seoService.addKeyword(keyword);
      expect(seoService.keywords, contains(keyword));
    });

    test('removeKeyword removes a keyword from the list', () {
      final keyword = 'creative mode';
      seoService.addKeyword(keyword);
      seoService.removeKeyword(keyword);
      expect(seoService.keywords, isNot(contains(keyword)));
    });

    test('addKeyword does not add duplicate keywords', () {
      final keyword = 'creative mode';
      seoService.addKeyword(keyword);
      seoService.addKeyword(keyword);
      expect(seoService.keywords.length, 1);
    });

    test('removeKeyword does not throw when keyword is not present', () {
      final keyword = 'non-existent keyword';
      expect(() => seoService.removeKeyword(keyword), returnsNormally);
    });
  });
}
