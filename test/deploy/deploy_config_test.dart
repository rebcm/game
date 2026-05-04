import 'package:flutter_test/flutter_test.dart';
import 'package:game/deploy/deploy_config.dart';

void main() {
  test('should return cloudflare api token', () {
    expect(DeployConfig.cloudflareApiToken, isNotEmpty);
  });
}
