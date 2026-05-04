import 'package:flutter_test/flutter_test.dart';
import 'package:game/providers/content_provider/content_provider_contract.dart';

void main() {
  group('ContentProviderContract', () {
    test('should be implemented by concrete providers', () {
      expect(() => ContentProviderContract(), throwsA(isA<TypeError>()));
    });
  });
}
