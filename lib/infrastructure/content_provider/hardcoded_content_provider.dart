import 'package:game/domain/content_provider/content_provider.dart';

class HardcodedContentProvider implements ContentProvider {
  @override
  Future<String> getTip() async {
    return 'Hardcoded tip';
  }
}
