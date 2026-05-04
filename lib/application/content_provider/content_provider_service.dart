import 'package:game/domain/content_provider/content_provider.dart';

class ContentProviderService {
  final ContentProvider _contentProvider;

  ContentProviderService(this._contentProvider);

  Future<String> getTip() async {
    return _contentProvider.getTip();
  }
}
