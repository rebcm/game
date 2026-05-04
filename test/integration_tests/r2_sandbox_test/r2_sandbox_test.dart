import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/r2/r2_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('R2 Sandbox Test', () {
    testWidgets('should upload and delete file', (tester) async {
      final r2Service = R2Service();
      await r2Service.init(useSandbox: true);

      final testFile = 'test_file.txt';
      final fileContent = 'Hello, World!';

      await r2Service.uploadFile(testFile, fileContent);
      expect(await r2Service.fileExists(testFile), true);

      await r2Service.deleteFile(testFile);
      expect(await r2Service.fileExists(testFile), false);
    });
  });
}
