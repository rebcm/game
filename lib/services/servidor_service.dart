import 'package:http/http.dart' as http;

class ServidorService {
  Future<http.Response> fazerRequisicao() async {
    final response = await http.get(Uri.parse('https://example.com/api'));

    return response;
  }
}
