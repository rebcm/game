import 'package:http/http.dart' as http;

class R2Service {
  final String _baseUrl;

  R2Service(this._baseUrl);

  Future<void> uploadChunk(String id, int version, String data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/r2/chunks'),
      headers: {'Content-Type': 'application/json'},
      body: '{"id": "", "version": , "data": ""}',
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar chunk');
    }
  }

  Future<String> getChunk(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/r2/chunks/'));
    if (response.statusCode == 404) {
      throw Exception('Chunk não encontrado');
    } else if (response.statusCode != 200) {
      throw Exception('Falha ao obter chunk');
    }
    return response.body;
  }
}
