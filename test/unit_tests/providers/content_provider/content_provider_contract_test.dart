import 'package:flutter_test/flutter_test.dart';
import 'package:game/providers/content_provider/content_provider_contract.dart';

class TestContentProvider implements ContentProviderContract {
  @override
  Future<String> getTip() async {
    return 'Test Tip';
  }
}

void main() {
  group('ContentProviderContract', () {
    test('should return a tip', () async {
      final provider = TestContentProvider();
      final tip = await provider.getTip();
      expect(tip, 'Test Tip');
    });
  });
}
