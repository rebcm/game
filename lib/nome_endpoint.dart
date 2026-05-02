import 'package:http/http.dart' as http;

class NomeEndpoint {
  final http.Client _client;

  NomeEndpoint(this._client);

  Future<bool> criarNome(String nome) async {
    final response = await _client.post(Uri.parse('https://api.exemplo.com/nomes'),
        headers: {'Content-Type': 'application/json'}, body: '{"nome": "$nome"}');

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
