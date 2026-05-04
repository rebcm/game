import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/cloudflare_r2/cloudflare_r2.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:game/services/cloudflare_r2/cloudflare_r2_config.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cloudflare R2 Integration Test', () {
    testWidgets('test put object', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final cloudflareR2 = CloudflareR2Impl(
        CloudflareR2Config.accountId,
        CloudflareR2Config.accessKeyId,
        CloudflareR2Config.secretAccessKey,
        CloudflareR2Config.bucket,
      );
      final response = await cloudflareR2.putObject(CloudflareR2Config.bucket, 'test_object', [1, 2, 3]);
      expect(response.statusCode, 200);
    });

    testWidgets('test get object', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final cloudflareR2 = CloudflareR2Impl(
        CloudflareR2Config.accountId,
        CloudflareR2Config.accessKeyId,
        CloudflareR2Config.secretAccessKey,
        CloudflareR2Config.bucket,
      );
      final response = await cloudflareR2.getObject(CloudflareR2Config.bucket, 'test_object');
      expect(response.statusCode, 200);
    });

    testWidgets('test delete object', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final cloudflareR2 = CloudflareR2Impl(
        CloudflareR2Config.accountId,
        CloudflareR2Config.accessKeyId,
        CloudflareR2Config.secretAccessKey,
        CloudflareR2Config.bucket,
      );
      final response = await cloudflareR2.deleteObject(CloudflareR2Config.bucket, 'test_object');
      expect(response.statusCode, 204);
    });
  });
}
