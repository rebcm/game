import 'package:http/http.dart' as http;

class ClienteApi {
  final http.Client _client;

  ClienteApi(this._client);

  Future<http.Response> obterDados() async {
    return await _client.get(Uri.parse('https://api.exemplo.com/dados'));
  }
}
