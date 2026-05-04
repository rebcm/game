import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_provider/content_provider_contract.dart';

void main() {
  test('should define getTip method', () async {
    final contentProvider = ContentProviderContractImpl();
    expect(contentProvider.getTip, isA<Future<String> Function()>());
  });
}

class ContentProviderContractImpl implements ContentProviderContract {
  @override
  Future<String> getTip() async {
    return 'Sample Tip';
  }
}
