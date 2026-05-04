import 'package:game/providers/content_provider/content_provider_contract.dart';

class HardcodedContentProvider implements ContentProviderContract {
  @override
  Future<String> getTip() async {
    return 'This is a hardcoded tip';
  }
}
