import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/testes/integracao/api/api_client.dart';
import 'package:rebcm/testes/integracao/config/ambiente.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de integração com API', () {
    late ApiClient apiClient;

    setUp(() {
      apiClient = ApiClient(ConfiguracaoAmbiente.urlApi);
    });

    testWidgets('Verificar resposta da API', (tester) async {
      final response = await apiClient.get('/healthcheck');
      expect(response.statusCode, 200);
    });
  });
}
