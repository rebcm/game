import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/seo/seo_service.dart';

void main() {
  test('should return main SEO keywords', () {
    final seoService = SeoService();
    expect(seoService.palavrasChavePrincipais, isNotEmpty);
  });

  test('should return secondary SEO keywords', () {
    final seoService = SeoService();
    expect(seoService.palavrasChaveSecundarias, isNotEmpty);
  });
}
