import 'package:game/domain/content_provider/content_provider_contract.dart';

class LocalContentProvider implements ContentProviderContract {
  @override
  Future<String> getTip() async {
    // Implement local storage logic here
    return 'This is a local tip';
  }
}
