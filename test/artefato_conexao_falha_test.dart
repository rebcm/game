import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('Artefato Conexão Falha Test', () {
    test('Testa falha de conexão com o servidor de artefatos', () async {
      try {
        final response = await http.get(Uri.parse('https://example.com/artefato-falha'));
        expect(response.statusCode, isNot(200));
      } catch (e) {
        expect(e, isA<http.ClientException>());
      }
    });
  });
}
