import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate token', (tester) async {
    final token = Platform.environment['CLOUDFLARE_TOKEN'];
    final zoneId = Platform.environment['CLOUDFLARE_ZONE_ID'];

    if (token == null || zoneId == null) {
      fail('CLOUDFLARE_TOKEN or CLOUDFLARE_ZONE_ID is not set');
    }

    final result = await Process.run('.github/scripts/token_validation/validate_token.sh', [token, zoneId]);
    expect(result.exitCode, 0);
  });
}
