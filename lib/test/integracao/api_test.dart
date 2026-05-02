import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API Integration Tests', () {
    testWidgets('Testa comunicação com API', (tester) async {
      final mockHttpClient = HttpMock();
      mockHttpClient.onGet(
        Uri.parse('${Constantes.urlApi}/mundos'),
        headers: any,
      ).thenReturnJson([]);

      final response = await http.get(Uri.parse('${Constantes.urlApi}/mundos'));

      expect(response.statusCode, 200);
      expect(response.body, '[]');
    });
  });
}
