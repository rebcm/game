import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/services/api_service/api_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('API error handling', (tester) async {
    final apiService = ApiService(Dio());
    try {
      await apiService.makeRequest(); // Assuming makeRequest is a method that triggers an error
      fail('Should throw');
    } on DioException catch (e) {
      expect(e.error, isA<ApiErrorModel>());
    }
  });
}
