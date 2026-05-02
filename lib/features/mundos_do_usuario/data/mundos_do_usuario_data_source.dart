import 'package:http/http.dart' as http;

class MundosDoUsuarioDataSource {
  Future<String> getMundosDoUsuario() async {
    final response = await http.get(Uri.parse('/api/worlds'));
    return response.body;
  }
}
