import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://construcao-criativa.workers.dev';

  Future<http.Response> getMundos() async {
    return await http.get(Uri.parse('$_baseUrl/mundos'));
  }

  Future<http.Response> getMundo(String id) async {
    return await http.get(Uri.parse('$_baseUrl/mundos/$id'));
  }

  Future<http.Response> criarMundo(String nome) async {
    return await http.post(
      Uri.parse('$_baseUrl/mundos'),
      headers: {'Content-Type': 'application/json'},
      body: '{"nome": "$nome"}',
    );
  }

  Future<http.Response> atualizarMundo(String id, String nome) async {
    return await http.put(
      Uri.parse('$_baseUrl/mundos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: '{"nome": "$nome"}',
    );
  }

  Future<http.Response> deletarMundo(String id) async {
    return await http.delete(Uri.parse('$_baseUrl/mundos/$id'));
  }
}
