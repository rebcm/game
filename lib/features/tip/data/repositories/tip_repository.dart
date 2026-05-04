import 'package:game/core/providers/content_provider.dart';

class TipRepository {
  final ContentProvider _contentProvider;

  TipRepository(this._contentProvider);

  Future<String> getTip() async {
    return _contentProvider.getTip();
  }
}
