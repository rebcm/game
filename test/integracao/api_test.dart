import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/config/constantes.dart';
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de integração de API', (tester) async {
    final response = await http.get(Uri.parse('${Constantes.urlApi}/endpoint'));
    expect(response.statusCode, 200);
  });
}
