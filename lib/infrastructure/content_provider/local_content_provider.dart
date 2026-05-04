import 'package:game/domain/content_provider/content_provider.dart';

class LocalContentProvider implements ContentProvider {
  @override
  Future<String> getTip() async {
    // Implement local storage logic here
    return 'Local tip';
  }
}
