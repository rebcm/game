import 'package:game/core/providers/content_provider.dart';

class HardcodedContentProvider implements ContentProvider {
  @override
  Future<String> getTip() async {
    return 'This is a hardcoded tip';
  }
}
