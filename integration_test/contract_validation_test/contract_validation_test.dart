import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/backend_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Contract Validation Test', () {
    testWidgets('Validate contract with real backend', (tester) async {
      final backendService = BackendService();

      final response = await backendService.getData();

      expect(response.statusCode, 200);
    });
  });
}
