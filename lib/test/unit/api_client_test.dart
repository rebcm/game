import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';
import 'package:rebcm/config/constantes.dart';

void main() {
  group('API Client Tests', () {
    test('Testa requisição GET para mundos', () async {
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
