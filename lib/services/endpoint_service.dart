import 'package:http/http.dart' as http;

class EndpointService {
  final http.Client _client;

  EndpointService(this._client);

  Future<http.Response> criarNome(String nome) async {
    final response = await _client.post(
      Uri.parse('https://api.exemplo.com/nomes'),
      headers: {'Content-Type': 'application/json'},
      body: '{"nome": "$nome"}',
    );

    return response;
  }
}
