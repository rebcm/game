import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/config/constantes.dart';

void main() {
  group('Testes de Integração API', () {
    test('Verificar resposta da API de construção criativa', () async {
      final response = await http.get(Uri.parse(Constantes.urlApiConstrucaoCriativa));
      expect(response.statusCode, 200);
    });
  });
}
