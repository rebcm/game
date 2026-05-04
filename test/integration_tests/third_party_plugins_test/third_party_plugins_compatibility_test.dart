import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Third Party Plugins Compatibility Test', () {
    testWidgets('permission_handler compatibility test', (tester) async {
      // Testa se o plugin permission_handler está funcionando corretamente
      final status = await Permission.location.status;
      expect(status, isNotNull);
    });
  });
}

