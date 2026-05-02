import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Verificar se a URL de preview retorna 200 OK', () async {
    String urlPreview = 'https://example.com/preview'; // Substituir pela URL real
    var response = await http.get(Uri.parse(urlPreview));
    expect(response.statusCode, 200);
  });
}
