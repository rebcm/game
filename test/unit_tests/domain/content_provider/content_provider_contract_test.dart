import 'package:flutter_test/flutter_test.dart';
import 'package:game/domain/content_provider/content_provider_contract.dart';

class TestContentProvider implements ContentProviderContract {
  @override
  Future<String> getTip() async {
    return 'Test Tip';
  }
}

void main() {
  group('ContentProviderContract', () {
    test('should get tip successfully', () async {
      final contentProvider = TestContentProvider();
      final tip = await contentProvider.getTip();
      expect(tip, 'Test Tip');
    });
  });
}
