import 'package:game/domain/content_provider/content_provider_contract.dart';
import 'package:game/infrastructure/content_provider/hardcoded_content_provider.dart';
import 'package:provider/provider.dart';

class ContentProviderModule {
  static void configure(ProviderScope scope) {
    scope.provide(ContentProviderContract, HardcodedContentProvider.new);
  }
}
