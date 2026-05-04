import 'package:game/services/content_provider/content_provider_contract.dart';

class HardcodedContentProvider implements ContentProviderContract {
  @override
  Future<String> getTip() async {
    return 'Hardcoded Tip';
  }
}
