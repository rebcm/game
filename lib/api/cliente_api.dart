import 'package:http/http.dart' as http;

class ClienteApi {
  final String _urlBase;

  ClienteApi(this._urlBase);

  Future<http.Response> fazerRequisicao(String endpoint) async {
    final url = Uri.parse('$_urlBase$endpoint');
    return await http.get(url);
  }
}
