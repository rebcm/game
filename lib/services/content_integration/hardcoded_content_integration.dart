import 'package:game/services/content_integration/content_integration_strategy.dart';

class HardcodedContentIntegration implements ContentIntegrationStrategy {
  @override
  Future<String> getContent() async {
    return 'Hardcoded content';
  }
}
